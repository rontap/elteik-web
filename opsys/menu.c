
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_LINE 100

int read_option() {
    int choice;
    printf("\n>> enter number: ");
    do {
        choice = getc( stdin );
    } while (choice < 48 || choice > 57);

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

void list_region(int reg) {

}
void add_user() {
    char name[MAX_LINE];
    char nth_reg[MAX_LINE];

    printf("\n full name: ");
    printf("\n how many times did you participate already?: ");
    int reg = select_region();
}
void delete_user() {

}
void edit_user() {

}



int menu() {
    printf("\n==== Húsvéti Locsolókirály ====");
    printf("\nSelect Action:");
    printf("\n1 - Sign up");
    printf("\n2 - Edit participant");
    printf("\n3 - Delete participant");
    printf("\n4 - List everyone");
    printf("\n5 - List a region");
    printf("\n0 - Exit");
    switch ( read_option() ) {
        case 0 : exit(0);
        case 1 : add_user(); break;
        case 5 : select_region(); break;
        default : return 0;

    }
}

