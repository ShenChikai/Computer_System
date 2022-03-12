// include header files
#include "user.h"
#include "stat.h"
#include "types.h"

void cpuIntensive() {
	int intense = 0;
	for (int i = 0; i < 40; i++) {
		intense = (intense / 2) + 2 * (intense / 3) + 2;
	}
}

// This test is made to prove Starvation Prevention (q0 -> q2 -> q0)
int main(void) {
	int forkedRet;	

	for (int f = 0; f < 4; f++) {
		forkedRet = fork();	
	}

	if (forkedRet > 0) {
		// In parent:
		// Do CPU or I/O intensive job <MORE INTENSIVE>
		for (int i = 0; i <= 40; i++) {
			printf(1, "Line %d, pid = %d.", i, getpid());
		}

		// getpinfo()
		getpinfo(getpid());

	} else {
		// In child:
		// Do CPU or I/O intensive job in each task
		// cpu intensive job for Child
		cpuIntensive();
		// getpinfo()
		getpinfo(getpid());


	}

	for (int f = 0; f < 4; f++) {
		wait();	// wait for child
	}

	wait();

	exit();

	return 0;
}