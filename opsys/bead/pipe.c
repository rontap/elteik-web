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

void pipe_act_parent() {
    printf(">> : Parent Scope\n");
    pause();
    printf(">> : got signal from @1\n");
    pause();
    printf(">> : got signal from @2\n");
}

void pipe_act_child(int child_no) {
    printf("@%i : Child Scope\n", child_no);

    char *const start = "WAKEUP";
    pid_t pppid = getppid();

    union sigval s_value_ptr;
    s_value_ptr.sival_ptr = start;
    sigqueue(pppid, SIGTERM, s_value_ptr);
    kill(pppid, SIGTERM);

    char msg_out[50] = "";
    char *msg_in[300];

    close(pipe_parent_to_1[1]);
    read(pipe_parent_to_1[0], &msg_in, sizeof(msg_in));
    close(pipe_parent_to_1[0]);

    printf("@%i : End Child Scope\n", child_no);
}