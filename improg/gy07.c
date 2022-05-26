#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(int argc, char *argv[])
{
    int lght = 99;

    char ch_arr[99][30] ;

    while (1) {
    lght = 99;
    for (int i=0; i< lght;i++) {
        scanf("%s",ch_arr[i] );

        if (strcmp(ch_arr[i],"EOF") == 0) {
            lght = i;
        }
    }
    for (int i=lght-1; i>= 0;i--) {

        printf("%s\n",ch_arr[i] );
    }
    }

     return 0;
}
