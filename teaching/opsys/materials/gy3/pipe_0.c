#include "libopsys.h"

//
// unnamed pipe example
//
int main(int argc, char *argv[]) {
    int pipefd[2]; // unnamed pipe file descriptor array
    pid_t pid;
    char sz[100];  // char array for reading from pipe


    if (pipe(pipefd) == -1) {
        perror("Hiba a pipe nyitaskor!");
        exit(EXIT_FAILURE);
    }
    if (pid == -1) {
        perror("Fork hiba");
        exit(EXIT_FAILURE);
    }

    sleep(1);    // sleeping a few seconds, not necessary
    close(pipefd[1]);  //Usually we close the unused write end
    printf("[child] elkezdi olvasni a csobol az adatokat!\n");
    read(pipefd[0], sz, sizeof(sz)); // reading max 100 chars
    printf("[child] olvasta uzenet: %s", sz);
    printf("\n");
    close(pipefd[0]); // finally we close the used read end


    exit(EXIT_SUCCESS);    // force exit, not necessary
}

 
