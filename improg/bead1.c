#include <stdio.h>
#include <stdlib.h>

int main()
{
    int dimensions;

    scanf("%d", &dimensions);
    if (dimensions < 1) return 0;

    for (int i=0 ; i < dimensions ; i++) {
        for (int k=0 ; k < dimensions-i+1 ; k++) {
            printf(" ");
        }
        for (int k=0; k < i+1; k++) {
            printf("X");
        }

        printf("  ");

        for (int k=0; k < i+1; k++) {
            printf("X");
        }
        printf("\n");
    }
    return 0;
}
