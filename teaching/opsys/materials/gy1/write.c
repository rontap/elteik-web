
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
    int i;
//    for (i = 0; i < atoi(argv[2]); i++) {
//
//        printf("%s\n", argv[1]);
//    }

    printf("%i\n", atoi(argv[2]));

//    errno = 0;
//    char *rest;
//    long int res = strtol(argv[2], &rest, 10);
//    printf("%li\nrest:[%s]\n", res, rest);
//    printf("%i\n", errno);
    // 0 0a 555a 9999999999
    return 0;
}
