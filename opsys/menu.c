
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_LINE 100

int read_option() {
    int choice;
    printf("\n>> enter number: ");
    do {
        choice = getc(stdin);
    } while (choice < 48 || choice > 57);
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
    }
    return;
};

void list_region(int should_list, FILE *fp) {
    int reg = should_list ? select_region() : 0;

    char *line = NULL;
    size_t len = 0;
    char *line_t = NULL;
    size_t len_t = 0;
    char *line_nth = NULL;
    size_t len_nth = 0;
    ssize_t read;

    fseek(fp, 0, SEEK_SET);
    while ((read = getline(&line, &len, fp)) != -1) {
        getline(&line_t, &len_t, fp);
        getline(&line_nth, &len_nth, fp);

        int line_ti = atoi(line_t);
        if (reg == 0 || line_ti == reg) {
            printf("-----\n");
            printf("name : %s", line);
            printf("town : ");
            print_region(line_ti);
            printf("\ngames: %s\n", line_nth);
        }
    }
}

void add_user(FILE *fp) {
    char *name;
    name = (char *) malloc(MAX_LINE + 1);
    char nth_reg[10];

    printf(">> Full name: ");
    fgets(name, MAX_LINE + 1, stdin);
    printf("\n>> How many times did you participate already?: ");
    fgets(nth_reg, 10, stdin);

    int nth_regi = atoi(nth_reg);
    int reg = select_region();

    printf("!!<%s><%i><%i>!!", name, reg, nth_regi);
    fprintf(fp, "%s%i\n%i\n", name, reg, nth_regi);
    free(name);
    printf("\n[+] User added");
}

void delete_user() {

}

void edit_user() {

}


int menu(FILE *fp) {
    printf("\n==== Húsvéti Locsolókirály ====");
    printf("\nSelect Action:");
    printf("\n1 - Sign up");
    printf("\n2 - Edit participant");
    printf("\n3 - Delete participant");
    printf("\n4 - List everyone");
    printf("\n5 - List a region");
    printf("\n0 - Exit");
    switch (read_option()) {
        case 0 :
            return 0;
        case 1 :

            add_user(fp);
            break;
        case 4 :
            list_region(0, fp);
            break;
        case 5 :
            list_region(1, fp);
            break;
        default :
            return 0;

    }
};

