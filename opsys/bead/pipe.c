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
}

/**
 * @param  msg in-out string
 */
void pipe_child_event(char *msg) {
    char *msg_origin = (char *) malloc(SIZEOF_MSG_IN);
    strcpy(msg_origin, msg);

    int delim = 0;
    msg[0] = '\0';

    char *curLine = msg_origin;

    // re-processing string
    while (curLine) {
        char *nextLine = strchr(curLine, '\n');
        if (nextLine) *nextLine = '\0';

        if (VERBOSE) printf("processing curLine=[%s]\n", curLine);

        // if current line is empty, we do not process it
        if (strcmp(curLine, "") != 0) {
            // we have reached the 'number of times participated' section
            if (delim++ % DATA_SIZE == 2) {
                // setting random number instead of actual value
                char int_buff[5];
                snprintf(int_buff, 5, "%d", randint());
                strcat(msg, int_buff);
            } else {
                strcat(msg, curLine);
            }
            strcat(msg, "\n");
        }

        curLine = nextLine ? (nextLine + 1) : NULL;
    }

    free(msg_origin);

}

void pipe_eval_winner(char *msg) {
    if (VERBOSE) printf("@@ EVAL WINNER\n");

    char name[MAX_LINE] = {"No winner"};
    int score = -1;

    char potential_name[MAX_LINE];
    int potential_score;

    int delim = 0;
    char *curLine = msg;

    // re-processing string
    while (curLine) {
        char *nextLine = strchr(curLine, '\n');
        if (nextLine) *nextLine = '\0';

        if (VERBOSE) printf("processing curLine=[%s]\n", curLine);

        // if current line is empty, we do not process it
        if (strcmp(curLine, "") != 0) {
            delim++;
            // we have reached the 'number of times participated' section
            if (delim % DATA_SIZE == 1) {
                strcpy(potential_name, curLine);
            } else if (delim % DATA_SIZE == 0) {
                potential_score = atoi(curLine);
                if (potential_score > score) {
                    score = potential_score;
                    strcpy(name, potential_name);
                }
            }
        }

        curLine = nextLine ? (nextLine + 1) : NULL;
    }

    printf("\n==== FINAL RESULTS ====\n\n");

    printf("== Winner Name : %s\n", name);
    printf("== Winner Score: %i\n", score);

    printf("\n==== \n");
};

void pipe_act_parent(FILE *fp) {
    printf(">> : Parent Scope\n");
    pause();
    printf(">> : got signal from @1\n");
    pause();
    printf(">> : got signal from @2\n");

    char *msg_in = (char *) calloc(MSG_IN_SIZE + 1, sizeof(char));

    for (int i = 0; i < 4; i++) {
        list_region(1, region_1[i], fp, sizeof(msg_in), msg_in);
    }

    close(pipe_parent_to_1[0]);
    write(pipe_parent_to_1[1], msg_in, SIZEOF_MSG_IN);
    close(pipe_parent_to_1[1]);

    free(msg_in);

    char *msg_in2 = (char *) calloc(MSG_IN_SIZE + 1, sizeof(char));

    for (int i = 0; i < 3; i++) {
        list_region(1, region_2[i], fp, sizeof(msg_in2), msg_in2);
    }

    close(pipe_parent_to_2[0]);
    write(pipe_parent_to_2[1], msg_in2, SIZEOF_MSG_IN);
    close(pipe_parent_to_2[1]);

    // ------ RECEIVING MESSAGES

    msg_in2[0] = '\0';
    char *msg_out = (char *) calloc(MSG_IN_SIZE + 1, sizeof(char));

    close(pipe_from_1[1]);
    read(pipe_from_1[0], msg_in2, SIZEOF_MSG_IN);
    close(pipe_from_1[0]);

    close(pipe_from_2[1]);
    read(pipe_from_2[0], msg_out, SIZEOF_MSG_IN);
    close(pipe_from_2[0]);

    strcat(msg_out, msg_in2);
    printf("\n=================\n%s\n===============\n", msg_out);

    pipe_eval_winner(msg_out);

    free(msg_in2);
    free(msg_out);


} //pipe_act_parent

void pipe_act_child(int child_no, FILE *fp) {
    printf("@%i : (( Child Scope\n", child_no);

    char *const start = "WAKEUP";
    pid_t pppid = getppid();

    union sigval s_value_ptr;
    s_value_ptr.sival_ptr = start;
    sigqueue(pppid, SIGTERM, s_value_ptr);

    kill(pppid, SIGTERM);

    char *msg_in = (char *) malloc(SIZEOF_MSG_IN);

    if (child_no == 1) {
        close(pipe_parent_to_1[1]);
        read(pipe_parent_to_1[0], msg_in, SIZEOF_MSG_IN);
        close(pipe_parent_to_1[0]);

        pipe_child_event(msg_in);

        close(pipe_from_1[0]);
        write(pipe_from_1[1], msg_in, SIZEOF_MSG_IN);
        close(pipe_from_1[1]);

    } else {
        close(pipe_parent_to_2[1]);
        read(pipe_parent_to_2[0], msg_in, SIZEOF_MSG_IN);
        close(pipe_parent_to_2[0]);

        pipe_child_event(msg_in);

        close(pipe_from_2[0]);
        write(pipe_from_2[1], msg_in, SIZEOF_MSG_IN);
        close(pipe_from_2[1]);
    }


    if (VERBOSE) printf("\nCHILD READ:\n[[%s]]\n", msg_in);

    free(msg_in);
    printf("@%i : End Child Scope\n", child_no);
    exit(0);
} //pipe_act_child

