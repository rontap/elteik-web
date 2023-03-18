#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#include <errno.h>
#include <time.h>
#include <unistd.h>
#include <fcntl.h>

#include <sys/time.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <sys/stat.h>

#ifndef LIBOPSYS_H
#define LIBOPSYS_H

// C Util függvények

//#define atoi DO_NOT_USE // use strtol instead
//#define usleep DO_NOT_USE
//#define sleep DO_NOT_USE


int sleep_ms(long milliseconds) {
    struct timespec rem;
    struct timespec req = {
            (int) (milliseconds / 1000),
            (milliseconds % 1000) * 1000000
    };
    return nanosleep(&req, &rem);
}

#endif //LIBOPSYS_H