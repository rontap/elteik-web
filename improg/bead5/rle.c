#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Pair {
    char c;
    int n;
};
struct Encoded {
    int length;
    struct Pair *arr;
};
struct Encoded *encode(char text[]) {
    printf("input : %s\n",text);

    struct Encoded *enc;
    enc = (struct Encoded *)malloc(sizeof(struct Encoded));

    enc->length = strlen(text);
    enc->arr = malloc(sizeof(struct Pair)*enc->length);

    int i=0;
    int encI = -1;

    while (text[i] != '\0') {
        if (i != 0 && text[i] == enc->arr[encI].c ) {
            enc->arr[encI].n++;
        }
        else {
            encI++;
            enc->arr[encI].c = text[i];
            enc->arr[encI].n = 1;
        }
        ////printf("\n%c---%d",text[i]);

        i++;
    }

    printf("output : ");
    for (int k = 0 ; k < encI+1; k++) {
        printf("%d%c", enc->arr[k].n, enc->arr[k].c);
    }


    enc->length = encI;
    return enc;
}

char *decode(struct Encoded *enc) {
    printf(" -> ");
    int encodedLength = 0;
    for (int k = 0 ; k < enc->length+1 ; k++) {
        encodedLength+= enc->arr[k].n;
    }
    char* out;
    out = malloc(sizeof(char)*(encodedLength+1));

    int fillUp = 0;
    for (int k = 0 ; k < enc->length+1 ; k++) {

        for (int l = 0 ; l < enc->arr[k].n; l++) {
             // printf("[%d-%c]",enc->arr[k].n,enc->arr[k].c);
              out[fillUp] = enc->arr[k].c;
              fillUp++;
        }
    }
    out[fillUp] = '\0';
    printf("%s",out);
    return out;
}

