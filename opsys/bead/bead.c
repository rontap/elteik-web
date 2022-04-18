// ---------
// Author: atatai || G07ZOE || opsys bead 1.
// ---------


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "main.c"
#include <time.h>

int main(void) {
    FILE *fp;

    srand(time(0));
    printf("\n==== Húsvéti Locsolókirály 2.0 ====");

    int exit_point = 1;

    while (exit_point) {
        fp = fopen("./dbf", "rw+");
        if (fp == NULL) {
            exit(EXIT_FAILURE);
        }
        exit_point = menu(fp);
        fclose(fp);
    }

    //printf("\n==== Exiting. Bye.\n");

    exit(EXIT_SUCCESS);

} // int main;

