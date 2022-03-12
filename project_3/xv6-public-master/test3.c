// include header files
#include "user.h"
#include "stat.h"
#include "types.h"

// This test is made to prove 1 process could hang in q0/q1 with Sleep
int main(void) {
	for (int i = 0; i < 10; i++) {
		sleep(2);
	}

	getpinfo(getpid());

	exit();

	return 0;
}