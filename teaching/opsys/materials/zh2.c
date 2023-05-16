//
// Created by rontap on 16/05/2023.
//
#include "libopsys.h"
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>

void handler(int signumber) {
    printf("[handler] Signal with number %i has arrived\n", signumber);
}

char pipe_1_loc[20];
char pipe_2_loc[20];


int main(int argc, char **argv) {
    errno = 0;
    sprintf(pipe_1_loc, "/tmp/%d_1", getpid());
    sprintf(pipe_2_loc, "/tmp/%d_2", getpid());
    char str[1024] = "String To Send\0";
    // 1a: signal
    signal(SIGUSR1, handler);
    signal(SIGUSR2, handler);

    printf("??");
    // 1b: pipe

    unlink(pipe_1_loc);
    unlink(pipe_2_loc);
    errno = 0;

    int pipe_fifo_1 = mkfifo(pipe_1_loc, O_CREAT | S_IRUSR | S_IWUSR);
    int pipe_fifo_2 = mkfifo(pipe_2_loc, O_CREAT | S_IRUSR | S_IWUSR);

    printf("%i %i %i", pipe_fifo_1, pipe_fifo_2, errno);

    printf("??");

    fflush(NULL);

    pid_t child_1, child_2 = 100;

    child_1 = fork();
    if (child_1 > 0) {
        child_2 = fork();
        if (child_2 > 0) {

            int pipe_1 = open(pipe_1_loc, O_WRONLY );
            int pipe_2 = open(pipe_2_loc, O_WRONLY );


            // 1a: signal
            printf("->signal\n");
            pause();
            printf("->2signal\n");
            pause();
            printf("->3signal\n");

            write(pipe_1, str, sizeof(str));
            write(pipe_2, str, sizeof(str));

            printf("%i %i , %i,", pipe_1, pipe_2, errno);



            sleep(3);

            // 1b : pipe

            printf("EOF");
            wait(NULL);
            wait(NULL);


            close(pipe_1);
            close(pipe_2);
        }
        sleep(5);
        char str2[1024] = "";
        //1a : signal

        int pipe_fd = open(pipe_2_loc, O_RDONLY | O_NONBLOCK);
        sleep(3);
        kill(getppid(), SIGUSR2);

        // 2a: pipe
        sleep(3);
        read(pipe_fd, str2, sizeof(str2));
        printf("a[ %s ] ", str2);

        return 0;

    }
    char str2[1024] = "";
    sleep(3);
    //1a : signal
    printf("c1k\n");
    int pipe_fd = open(pipe_1_loc, O_RDONLY | O_NONBLOCK);
    sleep(3);
    kill(getppid(), SIGUSR1);
    sleep(3);
    // 2a: pipe
    read(pipe_fd, str2, sizeof(str2));
    printf("b[ %s ] ", str2);

    return 0;


}