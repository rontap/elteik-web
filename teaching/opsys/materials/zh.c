//
// Created by rontap on 16/05/2023.
//
#include "libopsys.h"

void handler(int signumber) {
    printf("[handler] Signal with number %i has arrived\n", signumber);
}

int handle_child(int child_num) {
    printf("\n[%i]\n", getpid());
    kill(getppid(), SIGUSR1);
    return 0;
}

int handle_parent() {
    pause();
    pause();
}

int main() {

    signal(SIGUSR1, handler);

    pid_t child_1, child_2;

    child_1 = fork();

    if (child_1 == 0) {
        sleep(1);
        return handle_child(0);
    }

    child_2 = fork();

    if (child_2 == 0) {
        sleep(3);
        return handle_child(1);
    }

    handle_parent();

}