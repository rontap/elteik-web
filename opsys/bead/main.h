//
// Created by atatai on 17/04/22.
//
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


#ifndef ELTEIK_WEB_MAIN_H
#define ELTEIK_WEB_MAIN_H

#define MAX_LINE   (100)
#define DATA_SIZE  (3)      // how many lines each data is
#define INT_READL  (10)     // when reading int; line length
#define MAX_SCORE (100)

int randint() {
    return rand() / (RAND_MAX / MAX_SCORE+1);
};

#endif //ELTEIK_WEB_MAIN_H
