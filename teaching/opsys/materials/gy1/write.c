
# include "libopsys.h"
//call it with some parameters from the command line 

/**
 *  gcc -Wall -Werror=vla -pthread -lrt -std=c11 -pedantic -o write ./write.c

 * @param argc
 * @param argv
 * @return
 */
int main(int argc, char **argv)
//char** means an array of character arrays = array of strings
{
    long int i;
    char *rest;
    long int res = strtol(argv[2], &rest, 10);
    for (i = 0; i < res; i++) {
        printf("%s\n", argv[1]);
    }
    return 0;
}
