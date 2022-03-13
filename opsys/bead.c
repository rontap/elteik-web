// ---------
// Author: atatai || G07ZOE || opsys bead 1.
// ---------

#define _GNU_SOURCE

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "menu.c"

int main(void) {
    FILE *fp;


    fp = fopen("./dbf", "rw+");
    if (fp == NULL) {
        exit(EXIT_FAILURE);
    }

    menu(fp);
    fclose(fp);

    exit(EXIT_SUCCESS);

}

