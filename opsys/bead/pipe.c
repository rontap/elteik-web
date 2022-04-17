//
// Created by atatai on 17/04/22.
//
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/wait.h>
#include <errno.h>
#include <signal.h>

// assistant to the regional manager
int region_1[4] = {1, 2, 4, 6};
int region_2[3] = {3, 5, 7};

void handler(int signumber, siginfo_t *info, void *nonused) {
    printf("Signal with number %i has arrived\n", signumber);

}