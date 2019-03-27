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
    int stat;

    if(argint(0, &stat) < 0)
        return -1;
    exit(stat);
    return 0;
}

int
sys_wait(void)
{
    int *status;

    if(argptr(0, (void*)&status, sizeof(*status)) < 0)
        return -1;
    return wait(status);
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
  return myproc()->pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
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
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep((void *) &ticks, &tickslock);
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
sys_detach(void){
    int pid;
  if(argint(0, &pid) < 0)
    return -1;
  return detach(pid);
}

int
sys_policy(void){
    int pid;
    if(argint(0, &pid) < 0)
        return -1;
    policy(pid);
    return 0;
}

//TODO -need to understand how to call this sys_call
int
sys_priority(void){
    int pid;
    if(argint(0, &pid) < 0)
        return -1;
    priority(pid);
    return 0;
}


int
sys_wait_stat(void)
{
  //TODO - add perf struct to the args of the function
    int *status;
    struct perf *performance = 0;

    /*performance->ctime = 0;
    performance->ttime = 0;
    performance->stime = 0;
    performance->retime = 0;
    performance->rutime = 0;*/

    if(argptr(0, (void*)&status, sizeof(*status)) < 0)
        return -1;
    return wait_stat(status , performance);
}
