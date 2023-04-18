#include <sys/ipc.h>
#include <sys/msg.h>
#include <sys/types.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <wait.h>
#include "libopsys.h"
#include "libopsys.h"

struct message {
    long mtype; //ez egy szabadon hasznalhato ertek, pl uzenetek osztalyozasara
    char mtext[1024];
    int num;
};

// sending a message
int sysv_mq_send(int sysv_mq) {
    const struct message uz = {
            5,
            "Hajra Fradi!",
            rand() % 100
    };
    int status;

    status = msgsnd(
            sysv_mq,
            &uz,
            sizeof(struct message) - sizeof(long),
            0);
    // a 4. parameter gyakran IPC_NOWAIT, ez a 0-val azonos
    if (status < 0)
        perror("msgsnd");
    return 0;
}

// receiving a message. 
int sysv_mq_receive(int sysv_mq) {
    struct message uz;
    int status;
    // az utolso parameter(0) az message azonositoszama
    // ha az 0, akkor a sor elso uzenetet vesszuk ki
    // ha >0 (5), akkor az 5-os uzenetekbol a kovetkezot
    // ha <0, akkor absz. minimum érték
    // vesszuk ki a sorbol
    // MSG_COPY, IPC_NOWAIT, MSG_NOERROR
    status = msgrcv(
            sysv_mq,
            &uz,
            sizeof(struct message) - sizeof(long),
            5,
            0);

    if (status < 0) {
        perror("msgsnd");
    } else {
        printf("A kapott message kodja: %ld, "
               "szovege:  %s; \nrandom "
               "szama: %i\n", uz.mtype, uz.mtext, uz.num);
    }

    return 0;
}

int main(int argc, char *argv[]) {
    srand(
            time(NULL)
    ); //the starting value of random number generation

    pid_t child;
    int sysv_mq, status;
    key_t kulcs;

    // ftok hashing
    kulcs = ftok(argv[0], 1);
    printf("A kulcs: %d\n", kulcs);
    sysv_mq = msgget(kulcs, 0600 | IPC_CREAT);

    if (sysv_mq < 0) {
        perror("msgget error");
        return 1;
    }

    child = fork();


    if (child > 0) {
        // PARENT ===================================
        // parent process
        // PARENT ===================================
        sysv_mq_send(sysv_mq);
        sysv_mq_send(sysv_mq);
        sysv_mq_send(sysv_mq);
        sysv_mq_send(sysv_mq);
        sysv_mq_send(sysv_mq);
        // todo: multiple sys messages
        wait(NULL);
        // After terminating child process, the message queue is deleted.
        status = msgctl(sysv_mq, IPC_RMID, NULL);

        if (status < 0) {
            perror("msgctl error");
        }

        return 0;
    } else if (child == 0) {
        // CHILD ===================================
        // child process
        // CHILD ===================================
        sysv_mq_receive(sysv_mq);
        sysv_mq_receive(sysv_mq);
        sysv_mq_receive(sysv_mq);
        sysv_mq_receive(sysv_mq);
        sysv_mq_receive(sysv_mq);

        return 0;
        // The child process receives a message.
    } else {
        perror("fork");
        return 1;
    }


} 
