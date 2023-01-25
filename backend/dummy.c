#include <stdio.h>
#include <unistd.h>
int main(int argc, char** argv) {
	while(1) {
		printf("%s\n", argv[3]);
		sleep(1);
	}
}
