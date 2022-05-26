#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Person {
    char name[30];
    unsigned age;
    char job[30];
};

int size = 10;
int count = 0;
struct Person **iterator;

void freeUp() {
    for (int i = 0; i < count; i++) {
        free(iterator[count]);
    }
    free(iterator);
    size = 10;
    count = 0;
}

void add() {
    char scanned[100];
    unsigned int scanInt;

    iterator[count] = malloc(sizeof(struct Person));
    scanf("%s", scanned);
    if (strlen(scanned) >= 30) {
        freeUp();
        printf("error: max name  length is 30 characters. Because of the scope of this program, all your data is lost now.\n");
        return;
    }
    strcpy(iterator[count]->name, scanned);
    if (strlen(scanned) >= 30) {
        freeUp();
        printf("error: max job length is 30 characters. Because of the scope of this program, all your data is lost now.\n");
        return;
    }
    scanf("%s", scanned);
    strcpy(iterator[count]->job, scanned);

    scanf("%u", &scanInt);
    iterator[count]->age = scanInt;

    //printf("name: %s,job: %s,age: %u\n", iterator[count]->name, iterator[count]->job, iterator[count]->age);
    count++;
    return;
}


int exitAndFree() { //well its more like freeAndExit
    freeUp();
    return 0;
}

void list() {
    for (int i = 0; i < count; i++) {
        printf("%d: name: %s, job: %s, age: %u\n", i, iterator[i]->name, iterator[i]->job, iterator[i]->age);
    }
}

int main() {

    iterator = malloc(size * sizeof(struct Person));

    do {
        char inputs[100];
        //step 1: reading command
        //printf("\nenter command:");
        scanf("%s", inputs);

        if (strcmp(inputs, "a") == 0) {
            //printf("add: name, job, age\n");
            if (size == count) {
                size += 5;
                iterator = realloc(iterator, size * sizeof(struct Person));
            }
            add();
        } else if (strcmp(inputs, "l") == 0) {
            //printf("\n");
            list();
        } else if (strcmp(inputs, "x") == 0) {
            //printf("You may now turn off you computer.");
            return exitAndFree();

        } else {
            printf("invalid command. available commands: [a]dd [l]ist e[x]it\n");
        }

    } while (1);
    return 0;
}
