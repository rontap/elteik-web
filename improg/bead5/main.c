#include <stdio.h>
#include <stdlib.h>
#include "rle.h"
struct Encoded* code;
char* uncode;
int main()
{
    char text[256]; //itt nem volt követelmény, hogy dinamikusan használjuk tömböket.
    scanf("%s", &text);

    int i = 0;
    while (text[i] != '\0') {
        if (text[i] < 97 || text[i] > 122) {
            printf("Invalid Input. Only lowercase characters [a-z] are allowed.\nExiting.");
            return 1;
        }
        i++;
    }


    code = encode(text);
    uncode = decode(code);

    /**
    Lehetett volna a feladat kiírásán javítani, mert a specifikáció szerint nem lehet a main.c-ben külön free függvény,
    pedig programszerkezetileg jobb lenne
    **/

    for (int k = 0 ; k < code->length ; k++) {
            free(code->arr[0]);
    }
    free(uncode);
    free(code);

    return 0;
}

