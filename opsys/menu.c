#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_LINE   (100)
#define DATA_SIZE  (3)      // how many lines each data is
#define INT_READL  (10)     // when reading int; line length

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
            printf("\ngames: %s", line_nth);
        }
    }
    printf("\n[_] List done.\n");
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


int menu(FILE *fp) {
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
        case 2 :
            edit_user(fp, 1);
            break;
        case 3 :
            edit_user(fp, 0);
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
    printf("\n====");
    return 1;
};