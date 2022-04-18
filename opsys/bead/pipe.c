//
// Created by atatai on 17/04/22.
//
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/wait.h>
#include <errno.h>
#include "main.h"
#include <signal.h>

// assistant to the regional manager
int region_1[4] = {1, 2, 4, 6};
int region_2[3] = {3, 5, 7};

int pipe_parent_to_1[2];
int pipe_parent_to_2[2];
int pipe_from_1[2];
int pipe_from_2[2];

void handler(int signumber, siginfo_t *info, void *_) {
    printf("[handler] Signal with number %i has arrived\n", signumber);
    printf("info\n");
}

void pipe_act_parent(FILE *fp) {
    printf(">> : Parent Scope\n");
    pause();
    printf(">> : got signal from @1\n");
    pause();
    printf(">> : got signal from @2\n");

    char *msg_in = (char *) calloc(MSG_IN_SIZE + 1, sizeof(char));
    strcat(msg_in, "xx");

    for (int i = 0; i < 4; i++) {
        list_region(1, region_1[i], fp, sizeof(msg_in), msg_in);
    }

    printf("WRITE:\n[[%s]]\n", msg_in);

    close(pipe_parent_to_1[0]);
    write(pipe_parent_to_1[1], msg_in, SIZEOF_MSG_IN);
    close(pipe_parent_to_1[1]);

    free(msg_in);

    char *msg_in2 = (char *) calloc(MSG_IN_SIZE + 1, sizeof(char));

    for (int i = 0; i < 3; i++) {
        list_region(1, region_2[i], fp, sizeof(msg_in2), msg_in2);
    }

    printf("2 :: WRITE:\n[[%s]]\n", msg_in2);

    close(pipe_parent_to_2[0]);
    write(pipe_parent_to_2[1], msg_in2, SIZEOF_MSG_IN);
    close(pipe_parent_to_2[1]);

    printf(">> : End Parent Scope\n");
    free(msg_in2);
    sleep(2);

}

void pipe_act_child(int child_no, FILE *fp) {
    printf("@%i : (( Child Scope\n", child_no);


    char *const start = "WAKEUP";
    pid_t pppid = getppid();

    union sigval s_value_ptr;
    s_value_ptr.sival_ptr = start;
    sigqueue(pppid, SIGTERM, s_value_ptr);

    kill(pppid, SIGTERM);

    char msg_out[MSG_OUT_SIZE] = "";
    char *msg_in = (char *) malloc(SIZEOF_MSG_IN);


    if (child_no == 1) {
        close(pipe_parent_to_1[1]);
        read(pipe_parent_to_1[0], msg_in, SIZEOF_MSG_IN);
        close(pipe_parent_to_1[0]);
    } else {
        close(pipe_parent_to_2[1]);
        read(pipe_parent_to_2[0], msg_in, SIZEOF_MSG_IN);
        close(pipe_parent_to_2[0]);
    }


    printf("READ:\n[[%s]]\n", msg_in);

    printf("@%i : End Child Scope\n@@ Ending Scope ))\n", child_no);
    exit(0);
}