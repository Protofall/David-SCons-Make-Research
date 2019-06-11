#include <stdio.h>

int main(){

	#if MYFLAG == 1
		printf("Hi\n");
	#elif MYFLAG == 2
		printf("Bye\n");
	#else
		printf("Other\n");
	#endif

	return 0;
}
