#include "libopsys.h"

#define ARGS (2+1)
#define SIGNAL_LENGTH (5)
#define PID_LENGTH (100)

/**
 *
 * @param argc
 * @param argv
 * @details Task: Implement wrapper for kill
 * @return
 */
int main(int argc, char **argv) {
    /** usage:
     * kill SIGNAL PID
     */
    char signal_arg[SIGNAL_LENGTH], pid_arg[PID_LENGTH];

    if (argc != ARGS) {
        if (argc == 1) {
            // defering to user input
            printf("Enter Signal you want to send:\n");
            scanf("%s", signal_arg);
            printf("Enter PID you want to kill:\n");
            scanf("%s", pid_arg);
        } else {
            printf("To use kill, add exactly two parameters.\n");
            printf("Usage: kill SIGNAL PID");
            exit(1);
        }
    } else {
        strcpy(signal_arg, argv[1]);
        strcpy(pid_arg, argv[2]);
    }

    errno = 0;

    // parsing to long int
    char *signal_e, *pid_e;
    long int signal = strtol(signal_arg, &signal_e, 10);
    long int pid = strtol(pid_arg, &pid_e, 10);

    if (errno || *signal_e != '\0' || *pid_e != '\0') {
        printf("PID parameter should be a number.\n");
        exit(1);
    }


    //actual one line of important new code
    errno = 0;
    int result = kill(pid, signal);

    // error handing
    if (errno) {
        switch (errno) {
            case EINVAL:
                printf("The value of the sig argument is an invalid or unsupported signal number.\n");
                break;
            case EPERM:
                printf("The process does not have permission to send the signal to any receiving process.\n");
                break;
            case ESRCH:
                printf(" No process or process group can be found corresponding to that specified by pid..\n");
                break;
            default:
                printf("An error occurred during signal send.\n");
        }
    } else if (result == -1) {
        printf("An unspecified occurred during signal send.\n");
    } else if (result == 0) {
        printf("Signal Sent\n");
    }

    return 0;
}