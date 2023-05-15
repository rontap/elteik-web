//
// Created by rontap on 16/05/2023.
//
#include "libopsys.h"

void handler(int signumber) {
    printf("[handler] Signal with number %i has arrived\n", signumber);
}

int handle_child(int child_num, int pipe_n) {
    //1a : signal
    kill(getppid(), SIGUSR1);
    pause();
    // 2a: pipe
    char *place = NULL;
    read(pipe_n, &place, 4);
    printf("[%s]<---", place);

    return 0;
}

int main(int argc, char **argv) {
    printf("??");
    // 1a: signal
    signal(SIGUSR1, handler);

    printf("??");
    // 1b: pipe
//    int pipe_fifo_1 = mkfifo("/tmp/pipe_1", S_IRUSR | S_IWUSR);
//    int pipe_fifo_2 = mkfifo("/tmp/pipe_2", S_IRUSR | S_IWUSR);

    int pipe_1 = open("/tmp/pipe_1", S_IRUSR | S_IWUSR);
    int pipe_2 = open("/tmp/pipe_2", S_IRUSR | S_IWUSR);

    printf("??");

    pid_t child_1, child_2;

    child_1 = fork();

    if (child_1 == 0) {
        sleep(1);
        return handle_child(0, pipe_1);
    }

    child_2 = fork();

    if (child_2 == 0) {
        sleep(3);
        return handle_child(1, pipe_2);
    }

    // 1a: signal
    pause();
    pause();

    sleep(1);

    write(pipe_1, "CECA", 4);
    write(pipe_2, "CECA2", 4);

    kill(child_1, SIGUSR1);
    kill(child_2, SIGUSR1);
    // 1b : pipe

    printf("EOF");


}