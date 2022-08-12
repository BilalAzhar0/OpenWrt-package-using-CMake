#include <stdio.h>
#include "libs/Adder.h"

int main() {

	int First,Second;
	printf("Input first integer : ");
	scanf("%d", &First);
	printf("Input second integer : ");
	scanf("%d", &Second);
	printf("Output is : %d\n", adder(First,Second));

	return 0;
}

