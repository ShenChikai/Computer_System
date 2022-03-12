#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
  return fork();
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_getpid(void)
{
  return proc->pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = proc->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(proc->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}

int 
sys_procdump(void)
{
  procdump();
  return 0;
}

// kthread_create

int 
sys_kthread_create(void)
{
  void* (*start_func)();
  void* stack;
  int stack_size;

  if(argptr(0, (char**) &start_func, sizeof(void*)) < 0
    || argptr(1, (char**) &stack, sizeof(void*)) < 0
    || argint(2, &stack_size) < 0) {
      // not enough arg
      return -1;
  }

  // deploy syscall
  int tid = kthread_create(start_func, stack, stack_size);

  return tid;
}

// kthread_id

int 
sys_kthread_id(void)
{
  // deploy syscall
  return kthread_id();
}

// kthread_exit

int 
sys_kthread_exit(void)
{
  // deploy syscall
  kthread_exit();
  return 0;
}

// kthread_join

int 
sys_kthread_join(void)
{
  int thread_id;

  if(argint(0, &thread_id) < 0) {
    // no target thread_id passed
    return -1;
  }

  // deploy syscall
  return kthread_join(thread_id);
}

// kthread_mutex_alloc

int 
sys_kthread_mutex_alloc(void)
{
  // deploy syscall
  return kthread_mutex_alloc();
}

// kthread_mutex_dealloc

int 
sys_kthread_mutex_dealloc(void)
{
  int mutex_id;
  if(argint(0, &mutex_id) < 0) {
    // no target mutex_id passed
    return -1;
  }

  // deploy syscall
  return kthread_mutex_dealloc(mutex_id);
}

// kthread_mutex_lock

int 
sys_kthread_mutex_lock(void)
{
  int mutex_id;
  if(argint(0, &mutex_id) < 0) {
    // no target mutex_id passed
    return -1;
  }

  // deploy syscall
  return kthread_mutex_lock(mutex_id);
}

// kthread_mutex_unlock

int 
sys_kthread_mutex_unlock(void)
{
  int mutex_id;
  if(argint(0, &mutex_id) < 0) {
    // no target mutex_id passed
    return -1;
  }

  // deploy syscall
  return kthread_mutex_unlock(mutex_id);
}