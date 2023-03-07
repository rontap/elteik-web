
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h> //open,creat
#include <sys/types.h> //open
#include <sys/stat.h>
#include <errno.h> //perror, errno
#include <unistd.h>
#include "libopsys.h"

//make a copy of file given in argv[1] to file given in argv[2]
int main(int argc, char **argv) {

    printf("%c\n", (argv[0][2]));

    if (argc != 3) {
        perror("You have to use program with two arguments, the file names copy_from copy_to");
        exit(1);
    }
    FILE *f, *g;

    f = fopen(argv[1], "r");

    if (f == NULL) {
        perror("Error at opening the file\n");
        exit(1);
    }

    g = fopen(argv[2], "w+");
    if (g == NULL) {
        perror("Error at opening the file g\n");
        exit(1);
    }

    char c;

    while (fread(&c, sizeof(c), sizeof(c), f)) {
        printf("%c", c);
        size_t res = fwrite(&c, sizeof(c), sizeof(c), g);
        if (res != 1) {
            perror("There is a mistake in writing\n");
            exit(1);
        }
    }
    printf("\n");
    fclose(f);
    fclose(g);
    return 0;
}