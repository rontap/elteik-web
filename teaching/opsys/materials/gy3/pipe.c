#include <stdio.h>
#include <stdlib.h>
#include <unistd.h> // for pipe()
#include <string.h>
#include <sys/wait.h>

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
    pid = fork();    // creating parent-child processes
    if (pid == -1) {
        perror("Fork hiba");
        exit(EXIT_FAILURE);
    }

    if (pid == 0) {                // child process
        sleep(3);    // sleeping a few seconds, not necessary
        close(pipefd[STDOUT_FILENO]);  //Usually we close the unused write end
        printf("[child] elkezdi olvasni a csobol az adatokat!\n");
        read(pipefd[STDIN_FILENO], sz, sizeof(sz)); // reading max 100 chars
        printf("[child] olvasta uzenet: %s\n", sz);

//        read(pipefd[STDIN_FILENO], sz, sizeof(sz)); // reading max 100 chars
//        printf("[child] olvasta uzenet: %s\n", sz);
        //write(pipefd[STDOUT_FILENO], " CHILD >> PARENT", 15);
        printf("\n");
        close(pipefd[STDIN_FILENO]); // finally we close the used read end


    } else {    // szulo process
        printf("[parent] indul!\n");
        close(pipefd[STDIN_FILENO]); //Usually we close unused read end
        write(pipefd[STDOUT_FILENO], "PARENT 1> CHILD", 16);
//        write(pipefd[STDOUT_FILENO], "PARENT 2> CHILD", 16);
        //read(pipefd[STDIN_FILENO], sz, sizeof(sz)); // reading max 100 chars
        //printf("[parent] olvasta uzenet: %s\n", sz);
        close(pipefd[STDOUT_FILENO]); // Closing write descriptor
        printf("[parent] az adatokat a csobe!\n");


        fflush(NULL);    // flushes all write buffers (not necessary)
        wait(NULL);        // waiting for child process (not necessary)
        // try it without wait()
        printf("[parent] ends.");
    }
    exit(EXIT_SUCCESS);    // force exit, not necessary
}

 
