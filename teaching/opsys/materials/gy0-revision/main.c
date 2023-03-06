#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h> //open,creat
#include <sys/types.h> //open
#include <sys/stat.h>
#include <errno.h> //perror, errno
#include <string.h>
#include <unistd.h>

//
// Created by rontap on 05/03/2023.
//

int main() {
    int value = 5;
    int bignum = 100000;
    int *ptr;
    ptr = &value;

    printf("---\n");


    printf("%i\n", ptr);
    printf("%i\n", *ptr);
    printf("%i\n", &(*ptr));
    printf("%i\n", &value);

//    int **ptr_ptr;
//    ptr_ptr = &ptr;
//
//    printf("---\n");
//
//    printf("%i\n", ptr_ptr);
//    printf("%i\n", *ptr_ptr);
//    printf("%i\n", **ptr_ptr);
//
//    printf("---\n");


// hex
    int A = 0x001; // 0b00000000 00000000 00000001
    int B = 0x010; // 0b00000000 00000001 00000000
    int C = 0x100; // 0b00000001 00000000 00000000
    int E = 0x110; // 0b00000001 00000001 00000000
    int D = 0x101; // 0b00000001 00000000 00000001



//
//
//
//    printf("%i\n", bignum);
//    printf("%i\n", A);
//    printf("%i\n", B);
//    printf("%i\n", C);
//    printf("%i\n", A | B | C); // ||
//    printf("%i\n", A + B + C); // ||
//    printf("%i\n", A + A); // ||
//    printf("%i\n", A | A); // ||
//    printf("%i\n", C & E); // &&

}
