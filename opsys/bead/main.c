#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "main.h"
#include "pipe.c"

int read_option() {
    int choice;
    printf("\n>> Enter number: ");
    do {
        choice = getc(stdin);
    } while (choice < 48 || choice > 57); // must choose between 0-9
    getc(stdin);
    return choice - 48;
}

int select_region() {
    printf("\n>> Select region ====");
    printf("\n1 - Barátfa");
    printf("\n2 - Lovas");
    printf("\n3 - Szula");
    printf("\n4 - Kígyós-patak");
    printf("\n5 - Páskom");
    printf("\n6 - Káposztás kert");
    printf("\n7 - Malom telek");
    return read_option();
}

void print_region(int region_int) {
    switch (region_int) {
        case 1:
            printf("Barátfa");
            return;
        case 2:
            printf("Lovas");
            return;
        case 3:
            printf("Szula");
            return;
        case 4:
            printf("Kígyós-patak");
            return;
        case 5:
            printf("Páskom");
            return;
        case 6:
            printf("Káposztás kert");
            return;
        case 7:
            printf("Malom telek");
            return;
    }
    return;
};


/**
 *
 * @param should_list
 * @param should_choose_interact
 * @param fp
 * @param str_len
 * @param str_out
 */
void list_region(int should_list, int should_choose_interact , FILE *fp, int str_len, char *str_out) {
    int reg = should_list ? ( should_choose_interact ? should_choose_interact : select_region()) : 0;

    char *line = NULL;
    size_t len = 0;
    char *line_t = NULL;
    size_t len_t = 0;
    char *line_nth = NULL;
    size_t len_nth = 0;

    fseek(fp, 0, SEEK_SET);
    while ((getline(&line, &len, fp)) != -1) {
        getline(&line_t, &len_t, fp);
        getline(&line_nth, &len_nth, fp);

        int line_ti = atoi(line_t);
        if (reg == 0 || line_ti == reg) {
            if (str_len == 0) {
                // printing
                printf("-----\n");
                printf("name : %s", line);
                printf("town : ");
                print_region(line_ti);
                printf("\ngames: %s", line_nth);
            } else {
                //just gathering
                if (VERBOSE) printf(">> Gathered : %s , town %i , games %s", line, line_ti, line_nth);
                strcat(str_out, line);
                strcat(str_out, line_t);
                strcat(str_out, line_nth);
            }

        }
    }
    if (VERBOSE) printf("\n[_] List done.\n");
}

void add_user(FILE *fp) {
    char *name;
    name = (char *) malloc(MAX_LINE + 1);
    char nth_reg[INT_READL];

    printf(">> Full name: ");
    fgets(name, MAX_LINE + 1, stdin);
    printf(">> How many times did you participate already?: ");
    fgets(nth_reg, INT_READL + 1, stdin);

    int nth_regi = atoi(nth_reg);
    int reg = select_region();

    // jump to end of file
    while (getc(fp) != EOF) {};

    fprintf(fp, "%s%i\n%i\n", name, reg, nth_regi);
    free(name);
    printf("\n[+] User added\n");
}


void edit_user(FILE *fp, int edit_as_well) {
    fp = fopen("./dbf", "rw+");
    char name[MAX_LINE];
    FILE *fp_cp;
    char str[MAX_LINE];
    fp_cp = fopen("./dbf_temp", "w");

    printf(">> Username you want to change/delete: ");
    fgets(name, MAX_LINE + 1, stdin);
    int hook = 0;
    while (!feof(fp)) {
        fgets(str, MAX_LINE, fp);
        if (!feof(fp)) {
            hook--;
            if (strcmp(str, name) != 0) {
                if (hook < 0) {
                    fprintf(fp_cp, "%s", str);
                }
            } else {
                hook = DATA_SIZE - 1;
                if (edit_as_well) {
                    printf(">> Enter new Details ===\n");
                    add_user(fp_cp);
                }
            }
        }
    }; // while
    fclose(fp);
    fclose(fp_cp);
    remove("./dbf");
    rename("./dbf_temp", "./dbf");
    if (edit_as_well) {
        printf("[~] Done changing participant.\n");
    } else {
        printf("[×] Done removing participant.\n");
    }
}


void competition(FILE *fp) {
    printf("\n=== Starting Competition >>>\n");


    if ((pipe(pipe_parent_to_1) == -1 ||
         pipe(pipe_parent_to_2) == -1 ||
         pipe(pipe_from_1) == -1 ||
         pipe(pipe_from_2) == -1)) {
        perror("!!! Cannot open pipe\n Exiting!");
        exit(EXIT_FAILURE);
    }

    struct sigaction sig_act;

    sig_act.sa_sigaction = handler;
    sigemptyset(&sig_act.sa_mask);

    sig_act.sa_flags = SA_SIGINFO;
    sigaction(SIGTERM, &sig_act, NULL);


    int state = -1;
    pid_t child = fork();

    if (child < 0) {
        perror(":fork !!! Fork Error");
        exit(EXIT_FAILURE);
    }

    if (child > 0) {
        pid_t child = fork();

        if (child < 0) {
            perror(":fork -> parent !!! Fork Error");
            exit(EXIT_FAILURE);
        }
        if (child > 0) {
            // :fork -> parent :fork -> parent
            pipe_act_parent(fp);
            state = 0;
        } else {
            // :fork -> parent :fork -> child
            pipe_act_child(1, fp);
            state = 1;
        }
    } else {
        // :fork -> child
        sleep(1);
        pipe_act_child(2, fp);
        state = 2;
    }

    printf("<< @%i << endcompetition\n",state);
}

int menu(FILE *fp) {
    printf("\nSelect Action:");
    printf("\n1 - Sign up");
    printf("\n2 - Edit participant");
    printf("\n3 - Delete participant");
    printf("\n4 - List everyone");
    printf("\n5 - List a region");
    printf("\n6 - Start competition");
    printf("\n0 - Exit");

    switch (read_option()) {
        case 0 :
            return 0;
        case 1 :
            add_user(fp);
            return 0;
        case 2 :
            edit_user(fp, 1);
            return 0;
        case 3 :
            edit_user(fp, 0);
            return 0;
        case 4 :
            list_region(0, 0, fp, 0, 0);
            break;
        case 5 :
            list_region(1, 0, fp, 0, 0);
            break;
        case 6 :
            competition(fp);
            return 0;
        case 9 :
            list_region(1,0, fp, 1, 0);
            return 0;
        default :
            return 0;
    }
    printf("\n====");
    return 1;
};