//
// Created by atatai on 17/04/22.
//
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


#ifndef ELTEIK_WEB_MAIN_H
#define ELTEIK_WEB_MAIN_H

#define MAX_LINE    (100)
#define DATA_SIZE   (3)      // how many lines each data is
#define INT_READL   (10)     // when reading int; line length
#define MAX_SCORE   (100)
#define MSG_OUT_SIZE      (50)
#define MSG_IN_SIZE     (4000)
#define SIZEOF_MSG_IN (sizeof(char)*MSG_IN_SIZE)
#define VERBOSE (0)

int randint() {
    return rand() / (RAND_MAX / MAX_SCORE + 1);
};

void list_region(int should_list, int should_choose_interact, FILE *fp, int str_len, char *str_out);

#endif //ELTEIK_WEB_MAIN_H
