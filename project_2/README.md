# CSCI 350, Project 2
## Denny Shen
## dennyshe@usc.edu
### Thread table lock is implemented using a spinlock tied to the proc struct (acquire(proc->lock);) such that there can be only 1 thread holding onto this lock at a time, forming a thread synchronization within the process.
### This is added into sched() for debugging.
### Print statement could be in weird order and this should be normal due to the thread switch during printing.
### TBLOCKED is added in proc.h and updated in proc.c mutex lock function.
### In order to have the exact same ouput as the expected output, each testcase needs to be run with a new "make qemu-nox" command to reset the id where id increases each time a new thread is created and will not reset from 1 after destroyed in the same run.
### To complie, type "make qemu-nox", and then the testcase names.
