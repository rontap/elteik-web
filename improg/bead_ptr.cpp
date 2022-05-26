#include <iostream>
#include <stdio.h>
using namespace std;

int main()
{
    int szam = 5;
    int* mutato = &szam;

    printf("(&szam) : %p\n", &szam);

    printf("*(mutato) : %d\n", *(&szam));


    *mutato = *mutato + 1;

     printf("*(mutato) : %d\n", *mutato);

    cout << "Hello world!" << endl;
    return 0;
}
