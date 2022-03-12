// include header files
#include "user.h"
#include "stat.h"
#include "types.h"

void cpuIntensive() {
	//Initilize denominator
	double k = 1;
	  
	// Initilize sum
	double s = 0;
	  
	for(int i = 0; i <= 1000000; i++){
	  
	    // even index elements are positive
	    if (i % 2 == 0){
	        s += 4/k;
	    } else {
	  
	        // odd index elements are negative
	        s -= 4/k;
	  	}

	    // denominator is odd
	    k += 2;
	}
	printf(1, "pi = %d \n", s);
}

// This test is made to prove working Priority
int main(void) {

	int forkedRet = fork();
	
	
	if (forkedRet > 0) {
		// I/O intensive job for parent
		for (int i = 0; i <= 50; i++) {
			printf(1, "line %d, pid = %d.", i, getpid());
		}

		// output
		getpinfo(getpid());
		printf(1, "parent pid = %d getinfo ended\n", getpid());
	}else{
		// cpu intensive job for Child
		cpuIntensive();

		// output
		getpinfo(getpid());
		printf(1, "child pid = %d getinfo ended\n", getpid());
	}
	
	wait();	// wait for child

	exit();

	return 0;
}
