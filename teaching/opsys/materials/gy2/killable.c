//
// Created by rontap on 20/03/2023.
//
#include "libopsys.h"

void handler(int signumber) {
    printf("[handler] Signal with number %i has arrived\n", signumber);
    if (signumber == SIGUSR1) {
        printf("[handler] exiting\n");
        exit(0);
    }
}

int main() {
    printf("[main] Killable subject. My pid is: %i\n", getpid());

    struct sigaction sigact;
    sigact.sa_handler = handler;
    sigact.sa_flags = 0;
    sigaction(SIGILL, &sigact, NULL);
    //sigaction(SIGTERM, &sigact, NULL);
    sigaction(SIGUSR1, &sigact, NULL);
    sigaction(SIGUSR2, &sigact, NULL);
    sigaction(SIGSEGV, &sigact, NULL);

    sigset_t sigset;
    sigfillset(&sigset);
    sigdelset(&sigset, SIGILL);
    //sigdelset(&sigset, SIGTERM);
    sigdelset(&sigset, SIGUSR1); // !
    sigdelset(&sigset, SIGSEGV);
    sigdelset(&sigset, SIGBUS);

    while (true) {
        printf("[main] process sleeps\n");
        sigsuspend(&sigset);

        printf("[main] process resumes\n");
    }
}