#include <stdio.h>
#include <stdlib.h>
#include <string.h>


int isValidTime(char time[]) {
    if (strlen(time) != 5) return 0;
    if (time[2] != ':') return 0;

    char timePart[4];
    strncpy(timePart, time , 2);

    int timeSection = atoi(timePart);

    if (timeSection < 0 || timeSection >= 24) return 0;

    strncpy(timePart, time+3, 2);
    timeSection = atoi( timePart );
    if (timeSection < 0 || timeSection >= 60) return 0;

    return 1;
}

int isValidTodo(char todo[]) {
    int length = 0;
    while (todo[length] != '\0') {
        if (todo[length] < 65 || todo[length] > 122) return 0;

        length++;
    }
    return 1;
}

int main(int argc, char *argv[])
{
    if (argc < 3) {
        printf("Hibás bemenet!");
        return 1;
    }

    FILE *out;
    out = fopen( "todolist.txt" , "w");
    for (int i = 1 ; i< argc-1 ;i+=2) {
         if ( isValidTime(argv[i]) && isValidTodo(argv[i+1]) ) {
            fprintf(out , "%s - %s\n", argv[i], argv[i+1]);
         }
         else {
            printf("Hibás bemenet!");
         }
    }
    fclose( out );

    return 0;
}

