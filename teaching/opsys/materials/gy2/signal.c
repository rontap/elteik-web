#include <stdlib.h>
#include <stdio.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

void handler(int signumber) {
    printf("[handler] Signal with number %i has arrived\n", signumber);
}

int main() {

    signal(SIGUSR1, handler); //handler = SIG_IGN - ignore the signal (not SIGKILL,SIGSTOP),
    //handler = SIG_DFL - back to default behavior

    pid_t child = fork();
    if (child > 0) {
        pause(); //waits till a signal arrive
        printf("[parent]  Signal arrived\n", SIGUSR1);
        int status;
        wait(&status);
        printf("[parent]  process ended\n");
    } else {
        printf("[child]   Waits 3 seconds, then send a SIGTERM %i signal\n", SIGTERM);
        sleep(3);
        kill(getppid(), SIGUSR2);
        //1. parameter the pid number of process, we send the signal
        // 		if -1, then each of the processes of the same uid get the signal
        // 		we kill our bash as well! The connection will close
        //2. parameter the name or number of signal
        printf("[child]  process ended\n");
    }
    return 0;
}
