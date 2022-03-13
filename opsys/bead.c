#define _GNU_SOURCE


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "menu.c"

// prep

int main(void) {
    FILE *fp;
    char *line = NULL;
    size_t len = 0;
    ssize_t read;

    fp = fopen("./dbf", "rw+");
    if (fp == NULL)
        exit(EXIT_FAILURE);

    while ((read = getline(&line, &len, fp)) != -1) {
        //printf("Retrieved line of length %zu:\n", read);
        //printf("!!<%s> <%zu>!!\n" , line, len);
    }


   // add_user(fp);
    menu(fp);
    fclose(fp);
    return 0;

    if (line) { free(line); };




    exit(EXIT_SUCCESS);
}

