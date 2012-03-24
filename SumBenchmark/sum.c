#include <stdio.h>
#include <stdlib.h>

int main() {
	int n;
	long sum = 0;
	while (1) {
		if (scanf("%d", &n) != 1) break;
		sum += n;
	}
	printf("%ld\n", sum);
	return 0;
}
