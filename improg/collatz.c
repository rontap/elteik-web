#include <stdio.h>
#include <stdlib.h>

int main()
{
    int input = 0;

    //legal�bb egy iter�ci� mindig lesz.
    int iter = 1;

    scanf("%d", &input);

    while (input != 1) {
        iter++;
        if (input % 2 == 0) {
            input = input/2;
        } else {
            input = input*3 +1;
        }

        //ez itt igaz�b�l az�rt van, hogy ne legyen rond�n a sorozat ki�r�s v�g�n egy ronda ","
        if (input != 1) {
            printf("%d,", input);
        }
    }

    //helyette tudjuk, hogy mindig 1-el v�gzodik a sorozat
    printf("1\n%d", iter);

    return 0;
}
