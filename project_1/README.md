# CSCI 350, Project 1
## Denny Shen
## dennyshe@usc.edu
### To complie, type command "make qemu-nox" under "xv6-public-master folder". After qemu complied, type in the project name ("test_project1"; "date") to check results.
### The trace count functionality is based on the assumption that it starts counting as the process begins and print out on trace(0) only when trace(1) is called in pair (in order to match the given exptected outcome in the assignment pdf).
### Date syscall calls cmostime() function from lapic.c which is used to update the time with current time struct by reference, and the format is later parsed in date.c. The program date.c takes no responsibility of the accuracy of the current time since it is retrieved using given function cmostime() which is assumed to be correct.

