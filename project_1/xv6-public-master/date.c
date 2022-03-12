#include "types.h"
#include "user.h"
#include "date.h"

int main(int argc, char *argv[]){
	struct rtcdate r;

	if (date(&r)) {
		printf(2, "date failed\n");
		exit();
	}

	// your code to print the date-time
	int my_hour;
	char dn;
	if (r.hour > 12) {
		my_hour = r.hour - 12;
		dn = 'p';
	} else {
		my_hour = r.hour;
		dn = 'a';
	}

	char month_dict[12][12] = {
		"January","February","March","April","May","June","July","August","September","October","November","December" 
	};

	printf(1, "%d:%d %cm %s %d, %d \n", my_hour, r.minute, dn, month_dict[r.month - 1], r.day, r.year);
	//printf(1, "%d", my_hour);
	exit();
}