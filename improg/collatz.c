#include <stdio.h>
#include <stdlib.h>

int main()
{
    int input = 0;

    //legalább egy iteráció mindig lesz.
    int iter = 1;

    scanf("%d", &input);

    while (input != 1) {
        iter++;
        if (input % 2 == 0) {
            input = input/2;
        } else {
            input = input*3 +1;
        }

        //ez itt igazából azért van, hogy ne legyen rondán a sorozat kiírás végén egy ronda ","
        if (input != 1) {
            printf("%d,", input);
        }
    }

    //helyette tudjuk, hogy mindig 1-el végzodik a sorozat
    printf("1\n%d", iter);

    return 0;
}
