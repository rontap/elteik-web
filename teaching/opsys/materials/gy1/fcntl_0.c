#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h> //fork-hoz
#include <sys/stat.h>
#include <unistd.h> //fork
#include <string.h> //strlen
#include <fcntl.h> //lock
#include "libopsys.h"

int main() {
    int f;
    char text1[] = " Parent Parent Parent Parent Parent Parent Parent Parent Parent Parent ";
    int length1 = (int) strlen(text1);
    char text2[] = " Child Child Child Child Child Child Child Child Child Child Child ";
    int length2 = (int) strlen(text2);
    int i;
    f = open("data_0.txt", O_RDWR | O_TRUNC | O_CREAT, S_IRUSR | S_IWUSR);
    pid_t child = fork();
    if (child < 0) { //hiba
        perror("Error");
        exit(1);
    }
    if (child > 0) { //Parent process
        int j;
        for (j = 0; j < 25; j++) //to avoid too big data files
        {
            // printf("szulo %i ",getpid());
            for (i = 0; i < length1; i++) {
                write(f, &text1[i], 1);
                usleep(20);  //waits 20 milisec to slow down writing
                /* todo: ms_sleep */
            }
            write(f, "\n", 1);
        }
        int status;
        waitpid(child, &status, 0); //wait for the end of child process
    } else {
        int j;
        for (j = 0; j < 25; j++) //to avoid too big data file
        {
            for (i = 0; i < length2; i++) {
                write(f, &text2[i], 1);
                usleep(20);
            }
            write(f, "\n", 1);
        }
    }
    close(f);
    return 0;
}