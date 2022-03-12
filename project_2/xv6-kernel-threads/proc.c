#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "x86.h"
#include "proc.h"
#include "spinlock.h"

extern char getSharedCounter(int index);

void clearThread(struct thread * t);

struct {
  struct spinlock lock;
  struct proc proc[NPROC];
} ptable;

// spin lock on mutex table
struct {
  struct spinlock lock;
  struct kthread_mutex_t mutex[MAX_MUTEXES];
} mtable;

static struct proc *initproc;

int nextpid = 1;
int nexttid = 1;
int nextmid = 1;
extern void forkret(void);
extern void trapret(void);

static void wakeup1(void *chan);

void
pinit(void)
{
  initlock(&ptable.lock, "ptable");
}

struct thread*
allocthread(struct proc * p)
{
  struct thread *t;
  char *sp;
  int found = 0;

  for(t = p->threads; found != 1 && t < &p->threads[NTHREAD]; t++)
  {
    if(t->state == TUNUSED)
    {
      found = 1;
      t--;
    }
    else if(t->state == TZOMBIE)
    {
      clearThread(t);
      t->state = TUNUSED;
      found = 1;
      t--;
    }
  }

  if(!found)
    return 0;

  t->tid = nexttid++;
  t->state = TEMBRYO;
  t->parent = p;
  t->killed = 0;

  // Allocate kernel stack.
  if((t->kstack = kalloc()) == 0){
    t->state = TUNUSED;
    return 0;
  }
  sp = t->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *t->tf;
  t->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *t->context;
  t->context = (struct context*)sp;
  memset(t->context, 0, sizeof *t->context);
  t->context->eip = (uint)forkret;

  return t;
}



//PAGEBREAK: 32
// Look in the process table for an UNUSED proc.
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
// Must hold ptable.lock.
static struct proc*
allocproc(void)
{
  struct proc *p;
  struct thread *t;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;
  return 0;

found:
  p->state = USED;
  p->pid = nextpid++;

  t = allocthread(p);

  if(t == 0)
  {
    p->state = UNUSED;
    return 0;
  }
  p->threads[0] = *t;

  for(t = p->threads; t < &p->threads[NTHREAD]; t++)
    t->state = TUNUSED;

  return p;
}

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
  struct proc *p;
  struct thread *t;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  acquire(&ptable.lock);

  p = allocproc();
  t = p->threads;
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(t->tf, 0, sizeof(*t->tf));
  t->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  t->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  t->tf->es = t->tf->ds;
  t->tf->ss = t->tf->ds;
  t->tf->eflags = FL_IF;
  t->tf->esp = PGSIZE;
  t->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
  p->cwd = namei("/");

  t->state = TRUNNABLE;

  release(&ptable.lock);
}

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
  uint sz;

  acquire(&ptable.lock);
  sz = proc->sz;
  if(n > 0){
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0){
      release(&ptable.lock);
      return -1;
    }
  } else if(n < 0){
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0){
      release(&ptable.lock);
      return -1;
    }
  }
  proc->sz = sz;
  switchuvm(proc);
  release(&ptable.lock);
  return 0;
}

// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
  int i, pid;
  struct proc *np;
  struct thread *nt;

  acquire(&ptable.lock);

  // Allocate process.
  if((np = allocproc()) == 0){
    release(&ptable.lock);
    return -1;
  }
  nt = np->threads;

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
    kfree(nt->kstack);
    nt->kstack = 0;
    np->state = UNUSED;
    release(&ptable.lock);
    return -1;
  }

  np->sz = proc->sz;
  np->parent = proc;
  *nt->tf = *thread->tf;

  // Clear %eax so that fork returns 0 in the child.
  nt->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(proc->ofile[i])
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);

  safestrcpy(np->name, proc->name, sizeof(proc->name));

  pid = np->pid;

  nt->state = TRUNNABLE;

  release(&ptable.lock);

  return pid;
}

// kill_all

void
kill_all()
{
  struct thread *t;
  acquire(&proc->lock);

  for(t = proc->threads; t < &proc->threads[NTHREAD]; t++) {
    if(t->tid != thread->tid 
        && t->state != TRUNNING && t->state != TUNUSED) {
      t->state = TZOMBIE;
    }
  }

  thread->state = TZOMBIE;
  proc->killed = 1;
  release(&proc->lock);
}


// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
  struct proc *p;
  int fd;

  if(proc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd]){
      fileclose(proc->ofile[fd]);
      proc->ofile[fd] = 0;
    }
  }

  begin_op();
  iput(proc->cwd);
  end_op();
  proc->cwd = 0;

  acquire(&ptable.lock);

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == proc){
      p->parent = initproc;
      if(p->state == ZOMBIE)
        wakeup1(initproc);
    }
  }

  kill_all();

  // Jump into the scheduler, never to return.
  thread->state = TINVALID;
  proc->state = ZOMBIE;

  sched();
  panic("zombie exit");
}

void
clearThread(struct thread * t)
{
  if(t->state == TINVALID || t->state == TZOMBIE)
    kfree(t->kstack);

  t->kstack = 0;
  t->tid = 0;
  t->state = TUNUSED;
  t->parent = 0;
  t->killed = 0;
}

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
  struct proc *p;
  int havekids, pid;
  struct thread * t;

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != proc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;

        for(t = p->threads; t < &p->threads[NTHREAD]; t++)
          clearThread(t);

        freevm(p->pgdir);
        p->pid = 0;
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        release(&ptable.lock);
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  }
}

//PAGEBREAK: 42
// Per-CPU process scheduler.
// Each CPU calls scheduler() after setting itself up.
// Scheduler never returns.  It loops, doing:
//  - choose a process to run
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
  struct proc *p;
  struct thread *t;

  for(;;){
    // Enable interrupts on this processor.
    sti();
    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->state != USED)
          continue;

      for(t = p->threads; t < &p->threads[NTHREAD]; t++){
        if(t->state != TRUNNABLE)
          continue;

        // Switch to chosen process.  It is the process's job
        // to release ptable.lock and then reacquire it
        // before jumping back to us.


        proc = p;
        thread = t;
        switchuvm(p);
		
		 //cprintf("scheduler p loop 2 state=%d\n",p->state);
		
        t->state = TRUNNING;
        swtch(&cpu->scheduler, t->context);
		
				 //cprintf("scheduler p loop 3\n");
		
		
        switchkvm();


        // Process is done running for now.
        // It should have changed its p->state before coming back.
        proc = 0;
        if(p->state != USED)
          t = &p->threads[NTHREAD];
        
        thread = 0;
      }

    }
    release(&ptable.lock);

  }
}

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state. Saves and restores
// intena because intena is a property of this
// kernel thread, not this CPU. It should
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
  int intena;
  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(cpu->ncli != 1)
    panic("sched locks");
  if(thread->state == TRUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  if(holding(&proc->lock))        // adding this for debug
    panic("sched proc->lock");

  intena = cpu->intena;
  swtch(&thread->context, cpu->scheduler);
  cpu->intena = intena;
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
  acquire(&ptable.lock);  //DOC: yieldlock
  thread->state = TRUNNABLE;
  sched();
  release(&ptable.lock);
}

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
	
  if(proc == 0 || thread == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");

  // Must acquire ptable.lock in order to
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: 4lock1
    release(lk);
  }

  
  // Go to sleep.
  acquire(&proc->lock);
  thread->chan = chan;
  thread->state = TSLEEPING;
  release(&proc->lock);
  sched();

  // Tidy up.
  thread->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}

//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
  struct proc *p;
  struct thread *t;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == USED)
    {
      for(t = p->threads; t < &p->threads[NTHREAD]; t++)
        if(t->state == TSLEEPING && t->chan == chan)
          t->state = TRUNNABLE;
    }
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
}

// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
  struct proc *p;
  struct thread *t;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      for(t = p->threads; t < &p->threads[NTHREAD]; t++)
        if(t->state == TSLEEPING)
          t->state = TRUNNABLE;

      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}

// Kill the threads with of given process with pid.
// Thread won't exit until it returns
// to user space (see trap in trap.c).
void
killSelf()
{
  acquire(&ptable.lock);
  wakeup1(thread);
  thread->state = TINVALID; // thread must INVALID itself! - else two cpu's can run on the same thread
  sched();
}

//PAGEBREAK: 36
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
  static char *states[] = {
  [UNUSED]    "unused",
  [USED]    "used",
  [ZOMBIE]    "zombie"
  };
 
  int i;
  struct proc *p;
  struct thread *t;
  char *state;//, *threadState;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
      state = states[p->state];
    else
      state = "???";

    cprintf("%d %s %s\n", p->pid, state, p->name);
    for(t = p->threads; t < &p->threads[NTHREAD]; t++){
 

      if(t->state == TSLEEPING){
        getcallerpcs((uint*)t->context->ebp+2, pc);
        for(i=0; i<10 && pc[i] != 0; i++)
          cprintf("%p ", pc[i]);
        cprintf("\n");
      }
    }


  }
}

// kthread_create

int 
kthread_create(void* (*start_func)(), void* stack, int stack_size)
{
  struct thread * t;
  t = allocthread(proc);

  if(t == 0) {

    return -1; 

  } else {

    *t->tf = *thread->tf;                   // Copy current thread's trap frame
    t->tf->esp = (int) stack + stack_size;  // Make stack pointer inside trap frame = stack address + stack size
    t->tf->ebp = t->tf->esp;                // Update base pointer inside trap frame as stack pointer
    t->tf->eip = (int) start_func;          // Make instruction pointer inside trap frame start address
    t->state = TRUNNABLE;
    return t->tid;

  }
}

// kthread_id

int 
kthread_id()
{
  if(proc && thread) {
    return thread->tid;
  } else {
    return -1;  
  }
}

// kthread_exit

void 
kthread_exit()
{
  struct thread * t;
  int found = 0;

  acquire(&proc->lock);

  for(t = proc->threads; t < &proc->threads[NTHREAD]; t++) {
    if( t->tid != thread->tid 
          && (t->state != TUNUSED && t->state != TZOMBIE && t->state != TINVALID)) {
      found = 1;
      break;    // only 1 running t is enough
    }
  }

  if(found) { // there is other thread(s)
    release(&proc->lock);

    acquire(&ptable.lock);  // need this lock here~!
    wakeup1(thread);
  } else {    // no other thread
    release(&proc->lock);
    exit();
    wakeup(t);
  }

  thread->state = TZOMBIE;

  //release(&ptable.lock);
  
  sched();
}

// kthread_join

int 
kthread_join(int thread_id)
{
  struct thread * t;
  int found = 0;

  if(thread_id == thread->tid) {  // attempt to join with the thread itself
    return -1;
  }

  for(t = proc->threads; t < &proc->threads[NTHREAD]; t++){
    // loop to find the target thread
    if (t->tid == thread_id) {
      found = 1;
      break;
    }
  }  

  // Error: not found
  if (!found) return -1;

  acquire(&ptable.lock);

  while(found && (t->state != TUNUSED && t->state != TZOMBIE && t->state != TINVALID)) {
    // t is found and is not in a bad state
    sleep(t, &ptable.lock);
  }

  release(&ptable.lock);

  if(t->state == TZOMBIE) {
    clearThread(t);
  }

  return 0;
}

// kthread_mutex_alloc()

int 
kthread_mutex_alloc()
{
  struct kthread_mutex_t *m;
  
  acquire(&mtable.lock);
  // max mutex is 64, loop through to find a unused one
  for(m = mtable.mutex; m < &mtable.mutex[NPROC]; m++) {
    if (m->state == MUNUSED) {
      m->mid = nextmid++;
      m->state = MUNLOCKED;
      break;
    }
  }

  if(m == &mtable.mutex[NPROC]) {
    // 64, no spare mutex now
    release(&mtable.lock);
    return -1;
  }

  release(&mtable.lock);
  return m->mid;
}

// kthread_mutex_dealloc()

int 
kthread_mutex_dealloc(int mutex_id)
{
  struct kthread_mutex_t *m;

  acquire(&mtable.lock);
  // loop through to find the target mutex
  for(m = mtable.mutex; m < &mtable.mutex[NPROC]; m++) {
    if (m->mid == mutex_id) {
      // check if locked?
      if (m->state == MLOCKED) {
        release(&mtable.lock);
        return -1;
      } else {
        break;
      }
    }
  }

  if (m == &mtable.mutex[NPROC]) {
    // unused target not found
    release(&mtable.lock);
    return -1;
  } else {
    // target found
    m->mid = 0;
    m->state = MUNUSED;
    // no other value

    release(&mtable.lock);
    return 0;
  }

  release(&mtable.lock);
  return -1;
}

// kthread_mutex_lock()

int 
kthread_mutex_lock(int mutex_id)
{
  struct kthread_mutex_t *m;
  
  acquire(&mtable.lock);
  // loop through to find the target mutex
  for(m = mtable.mutex; m < &mtable.mutex[NPROC]; m++) {
    if (m->mid == mutex_id) {
      break;
    }
  }

  if(m == &mtable.mutex[NPROC] || m->state == MUNUSED) {
    // not found
    release(&mtable.lock);
    return -1;
  }

  // spinlock
  while(m->state == MLOCKED) {
    sleep(m, &mtable.lock);
  }

  if(m->state != MUNLOCKED) {
    // locked by some other thread?
    thread->state = TBLOCKED;
    sched();

    release(&mtable.lock);
    return -1; 
  }

  m->state = MLOCKED;

  release(&mtable.lock);

  return 0;
}

// kthread_mutex_unlock()

int 
kthread_mutex_unlock(int mutex_id)
{
  struct kthread_mutex_t *m;
  
  acquire(&mtable.lock);
  // loop through to find the target mutex
  for(m = mtable.mutex; m < &mtable.mutex[NPROC]; m++) {
    if (m->mid == mutex_id) {
      break;
    }
  }

  if(m == &mtable.mutex[NPROC] || m->state != MLOCKED)
  {
    // Unused or Unlocked
    release(&mtable.lock);
    return -1;
  }

  m->state = MUNLOCKED;
  wakeup1(m); 

  release(&mtable.lock);
  return 0;
}