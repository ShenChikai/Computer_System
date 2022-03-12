#include <stddef.h>
#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "x86.h"
#include "proc.h"
#include "spinlock.h"

// initialize process queues and their counters
struct proc* q0[NPROC];
struct proc* q1[NPROC];
struct proc* q2[NPROC];
int c0 = -1;
int c1 = -1;
int c2 = -1;

struct {
  struct spinlock lock;
  struct proc proc[NPROC];
} ptable;

static struct proc *initproc;

int nextpid = 1;
extern void forkret(void);
extern void trapret(void);

static void wakeup1(void *chan);

void
pinit(void)
{
  initlock(&ptable.lock, "ptable");
}

// Must be called with interrupts disabled
int
cpuid() {
  return mycpu()-cpus;
}

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
  int apicid, i;
  
  if(readeflags()&FL_IF)
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  panic("unknown apicid\n");
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
  c = mycpu();
  p = c->proc;
  popcli();
  return p;
}

//PAGEBREAK: 32
// Look in the process table for an UNUSED proc.
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  // before found and after searching:
  // initialize process properties!
  p->Ticks = 0;
  p->total_ticks = 0;
  p->wait_time = 0;
  p->num_stats_used = 0;

  // reset scheduler properties (declared in pstat.h)
  for (size_t i = 0; i < NSCHEDSTATS; i++) {
    (p->sched_stats[i]).start_tick = 0;
    (p->sched_stats[i]).duration = 0;
    (p->sched_stats[i]).priority = 0;
  }

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;

  // 3 loops for 3 properties:
  if (p->pid > 0){
    // first loop for q0
    for (int i = 0; i <= c0; i++) {
      if (p == q0[i]) {
        // shift all left
        for (int shift = i + 1; shift <= c0; shift++) {
          q0[shift - 1] = q0[shift];
        }
        // delete q0[i]
        q0[c0] = NULL;
        c0--;
      }
    }
    // second loop for q1
    for (int i = 0; i <= c1; i++) {
      if (p == q1[i]) {
        // shift all left
        for (int shift = i + 1; shift <= c1; shift++) {
          q1[shift - 1] = q1[shift];
        }
        // delete q0[i]
        q1[c1] = NULL;
        c1--;
      }
    }
    // third loop for q2
    for (int i = 0; i <= c2; i++) {
      if (p == q2[i]) {
        // shift all left
        for (int shift = i + 1; shift <= c2; shift++) {
          q2[shift - 1] = q2[shift];
        }
        // delete q0[i]
        q2[c2] = NULL;
        c2--;
      }
    }


  }

  // after delete unused process
  
  // initialize process properties!
  p->Ticks = 0;
  p->total_ticks = 0;
  p->wait_time = 0;
  p->num_stats_used = 0;

  // reset scheduler properties (declared in pstat.h)
  for (size_t i = 0; i < NSCHEDSTATS; i++) {
    (p->sched_stats[i]).start_tick = 0;
    (p->sched_stats[i]).duration = 0;
    (p->sched_stats[i]).priority = 0;
  }

  for (int i = 0; i < 3; i++) {
    p->ticks[i] = 0;
    p->times[i] = 0;
  }

  // Add p into first priority queue
  c0++;
  q0[c0] = p;


  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  // Reset schedule stats
  for (int i = 0; i < NPROC; i++) {
    // set them to point to null
    q0[i] = NULL;
    q1[i] = NULL;
    q2[i] = NULL;
  }

  p = allocproc();
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  p->tf->es = p->tf->ds;
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
  p->cwd = namei("/");

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);

  p->state = RUNNABLE;

  release(&ptable.lock);
}

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
  switchuvm(curproc);
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
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));

  pid = np->pid;

  acquire(&ptable.lock);

  np->state = RUNNABLE;

  release(&ptable.lock);

  return pid;
}

// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd]){
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
  iput(curproc->cwd);
  end_op();
  curproc->cwd = 0;

  acquire(&ptable.lock);

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
      if(p->state == ZOMBIE)
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;
  sched();
  panic("zombie exit");
}

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
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
    if(!havekids || curproc->killed){
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}

// priority boost to avoid starvation
void boost (int n) {
  // declare reuseable proc p
  struct proc *p;
  // Increase wait time of all RUNNABLE processes in q2 according to last process' duration
  for (int i = 0; i <= c2; i++) {
    if (q2[i] != NULL && q2[i]->state == RUNNABLE) {
      q2[i]->wait_time = q2[i]->wait_time + n;
      // If any of the process' wait time passes 50
      if (q2[i]->wait_time > 50) {
        // boost it into the end of first priority queue, q0
        //// first reset the ticks/wait in q2 to create a copy
        q2[i]->Ticks = 0;
        q2[i]->wait_time = 0;
        // p = p_to_boost
        p = q2[i];              // the new copy
        c0++;
        q0[c0] = p;             // Change priority of p
        // shift left
        for (int shift = i + 1; shift <= c2; shift++) {
          q2[shift -1] = q2[shift];
        }
        // Delete from q2
        q2[c2] = NULL;
        c2--;
      }
    }
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
  struct cpu *c = mycpu();
  c->proc = 0;
  
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    
    // first loop for q0:
    // If q0 is not empty:
    if (c0 > -1) {
      // Loop to find RUNNABLE process in the q0 array
      for (int i = 0; i <= c0; i++) {
        // if q0[i] —>state != RUNNABLE
        if (q0[i]->state != RUNNABLE) continue;
        // p = q0[i]
        p = q0[i];
        // c->proc = p
        c->proc = p;
        // switchuvm(p)
        switchuvm(p);
        // p->state = RUNNING
        p->state = RUNNING;
        // WRITE STATS —> start_tick and priority
        (p->sched_stats[p->num_stats_used]).start_tick = ticks;
        (p->sched_stats[p->num_stats_used]).priority = 0;
        // swtch(&(c->scheduler), p->context);
        swtch(&(c->scheduler), p->context);
        // switchkvm()
        switchkvm();
        // Duration = ticks - start
        (p->sched_stats[p->num_stats_used]).duration = ticks - (p->sched_stats[p->num_stats_used]).start_tick;
        // p->times[0]++;
        p->times[0]++;
        // p->ticks[0] = duration;
        p->ticks[0] = (p->sched_stats[p->num_stats_used]).duration;
        // p->num_stats_used++;
        p->num_stats_used++;
        // Change total_ticks in proc if you have
      

        // if(p->ticks >= 1)
        if(p->Ticks >= 1) {
          // p->ticks = 0;
          p->Ticks = 0;
          // copy proc to lower priority queue ^_^
          // increase c1 count
          c1++;
          q1[c1] = p;
          // … other changes necessary ???
          // q1[c1] = p; // put at the end of the q1
          // q0[i] = 0;// delete proc from q0 ^_^
          // Shift all left from i, Dont forget counter-- and last element of array
          for (int shift = i + 1; shift <= c0; shift++) {
            q0[shift-1] = q0[shift];
          }
          q0[c0] = NULL;
          c0--;
        }
        // boost()s
        boost(1);
        // c->proc = 0;  Reset cpu
        c->proc = 0;
      }

    }

    // second loop for q1:
    // If q1 is not empty:
    if (c1 > -1) {
      // Loop to find RUNNABLE process in the q0 array
      for (int i = 0; i <= c1; i++) {
        // if q0[i] —>state != RUNNABLE
        if (q1[i]->state != RUNNABLE) continue;
        // p = q0[i]
        p = q1[i];
        // c->proc = p
        c->proc = p;
        // switchuvm(p)
        switchuvm(p);
        // p->state = RUNNING
        p->state = RUNNING;
        // WRITE STATS —> start_tick and priority
        (p->sched_stats[p->num_stats_used]).start_tick = ticks;
        (p->sched_stats[p->num_stats_used]).priority = 1;
        // swtch(&(c->scheduler), p->context);
        swtch(&(c->scheduler), p->context);
        // switchkvm()
        switchkvm();
        // Duration = ticks - start
        (p->sched_stats[p->num_stats_used]).duration = ticks - (p->sched_stats[p->num_stats_used]).start_tick;
        // p->times[0]++;
        p->times[1]++;
        // p->ticks[0] = duration;
        p->ticks[1] = (p->sched_stats[p->num_stats_used]).duration;
        // p->num_stats_used++;
        p->num_stats_used++;
        // Change total_ticks in proc if you have

        // if(p->ticks >= 1)
        if(p->Ticks >= 2) {
          // p->ticks = 0;
          p->Ticks = 0;
          // copy proc to lower priority queue ^_^
          // increase c1 count
          c2++;
          q2[c2] = p;
          // … other changes necessary ???
          // q1[c1] = p; // put at the end of the q1
          // q0[i] = 0;// delete proc from q0 ^_^
          // Shift all left from i, Dont forget counter-- and last element of array
          for (int shift = i + 1; shift <= c1; shift++) {
            q1[shift-1] = q1[shift];
          }
          q1[c1] = NULL;
          c1--;
        }
        // boost()s
        boost(2);
        // c->proc = 0;  Reset cpu
        c->proc = 0;
      }

    }

    // third loop for q2:
    // If q2 is not empty:
    if (c2 > -1) {
      // Loop to find RUNNABLE process in the q0 array
      for (int i = 0; i <= c2; i++) {
        // if q0[i] —>state != RUNNABLE
        if (q2[i]->state != RUNNABLE) continue;
        // p = q0[i]
        p = q2[i];
        // c->proc = p
        c->proc = p;
        // switchuvm(p)
        switchuvm(p);
        // p->state = RUNNING
        p->state = RUNNING;
        // WRITE STATS —> start_tick and priority
        (p->sched_stats[p->num_stats_used]).start_tick = ticks;
        (p->sched_stats[p->num_stats_used]).priority = 2;
        // swtch(&(c->scheduler), p->context);
        swtch(&(c->scheduler), p->context);
        // switchkvm()
        switchkvm();
        // Duration = ticks - start
        (p->sched_stats[p->num_stats_used]).duration = ticks - (p->sched_stats[p->num_stats_used]).start_tick;
        // p->times[0]++;
        p->times[2]++;
        // p->ticks[0] = duration;
        p->ticks[2] = (p->sched_stats[p->num_stats_used]).duration; 
        // p->num_stats_used++;
        p->num_stats_used++;
        // Change total_ticks in proc if you have

        // boost early for c2
        boost(8);

        // if(p->ticks >= 1)
        if(p->Ticks >= 8) {
          // p->ticks = 0;
          p->Ticks = 0;
          // copy proc to lower priority queue ^_^
          // increase c1 count
          c2++;
          q2[c2] = p;
          // … other changes necessary ???
          // q1[c1] = p; // put at the end of the q1
          // q0[i] = 0;// delete proc from q0 ^_^
          // Shift all left from i, Dont forget counter-- and last element of array
          for (int shift = i + 1; shift <= c2; shift++) {
            q2[shift-1] = q2[shift];
          }
          q2[c2] = NULL;
          c2--;
        }
        // c->proc = 0;  Reset cpu
        c->proc = 0;
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
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
  swtch(&p->context, mycpu()->scheduler);
  mycpu()->intena = intena;
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
  acquire(&ptable.lock);  //DOC: yieldlock
  myproc()->state = RUNNABLE;
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
  struct proc *p = myproc();
  
  if(p == 0)
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
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }
  // Go to sleep.
  p->chan = chan;
  p->state = SLEEPING;

  sched();

  // Tidy up.
  p->chan = 0;

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

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == SLEEPING && p->chan == chan)
      p->state = RUNNABLE;
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

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
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
  [EMBRYO]    "embryo",
  [SLEEPING]  "sleep ",
  [RUNNABLE]  "runble",
  [RUNNING]   "run   ",
  [ZOMBIE]    "zombie"
  };
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}

// add get info (declared in proc.h)
int getpinfo (int pid) {
  // Get lock
  acquire(&ptable.lock);
  // Get current process With for loop through all processes in ptable
  struct proc * p;
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
    if ((p != NULL) && p->pid == pid) {
      goto found;
    } 
  }

  // If not found, Release & break
  release(&ptable.lock);
  return -1;


  found:
    cprintf("*******************************************\n");
    // proc->name
    cprintf("name= %s, pid= %d\n", p->name, p->pid);
    // proc->wait_time
    cprintf("wait time= %d\n", p->wait_time);
    // proc->ticks[0],ticks[1],ticks[2]
    cprintf("ticks= {%d, %d, %d}\n", p->ticks[0], p->ticks[1], p->ticks[2]);
    // proc->times[0],times[1],times[2]
    cprintf("times= {%d, %d, %d}\n", p->times[0], p->times[1], p->times[2]);
    cprintf("*******************************************\n");
    // For each stat until num_of_stats, Get/cprintf start_tick, duration and priority from each valid item in sched_stats
    for (int i = 0; i < p->num_stats_used; i++) {
      cprintf("start=%d, duration=%d, priority=%d\n", p->sched_stats[i].start_tick, p->sched_stats[i].duration, p->sched_stats[i].priority);
    }
    // Release lock
    release(&ptable.lock);
    // Return 0 
    return 0;

}