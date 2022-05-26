#include <stdio.h>
#include <stdlib.h>
#include <string.h>
char chars[10] = "ABCDEFGHIJ";
int mine[100];
int playfield[100];
int mines = 1;
char code[200];

int main()
{
    for (int i = 0; i< 100;i++) {
        mine[i] =0;
        playfield[i] = 0;
    }

    time_t t;
    srand((unsigned) time(&t));


    for (int i = 0; i< mines;i++) {
        int pos = rand() % 100;
        if (mine[pos] == 9) {
            i--;
        } else {
            mine[pos]=9;

        }
    }

    for (int i=0; i<100;i++) {
        if (mine[i] != 9) {

            mine[i] = (  (mine[i+1-10] == 9) + (mine[i-1-10] == 9) + (mine[i-10] == 9)+
                         (mine[i+1] == 9) +   /*itten vagyunk*/ (mine[i-1] == 9)+
                         (mine[i+10-1]  == 9)+ (mine[i+10] == 9) + (mine[i+10+1] == 9)
                    );

        }
    }

    printf("MineSweeper2000\n");
    printFl();


    int shouldRead = 1;
    do {
       char anw[100];
       for (int i = 0; i< 10;i++) {
        printf("\n%c", chars[i]);
        for (int k = 0 ; k<10 ; k++) {
            int loc =  mine[(i*10 +k)] ;
            int playfieldLoc =  playfield[(i*10 +k)] ;
            if (playfieldLoc == 9) {
                printf(" %d",loc);

            }
            else {
                printf(" ?");
            }

        }
        }
        printf("\n==========\n");
       printf("Enter coordinate: ");
       scanf("%s", anw);

        if (strlen(anw) > 2) {
                saveOrBackup(anw);
            }
        else {

        const char *ptr = strchr(chars, anw[0]);
        if (ptr) {
            int index = ptr - chars ;
            int snd = (anw[1] - '0');
            int loc = mine[index*10 + snd];

            if (loc == 9 ) {
                printf("You Died. ");
                scanf("%s", anw);
                shouldRead = 0;
            }
            else {
                playfield[index*10+snd]=9;

            }

            int didFindUncovered=0;
            for (int i=0; i< 100 ; i++) {
                if ( mine[i] !=9 && playfield[i] != 9) {
                    didFindUncovered = 1;
                    break;
                }
            }
            if (didFindUncovered==0) {
                printf(" : You won! Good Job.");
                scanf("%s", anw);
                shouldRead = 0;
            }
        }
        }

               // system("cls");

    } while(shouldRead);
    return 0;
}

void saveOrBackup( anw) {
    FILE * fp;
    int willSave = 2;

    if (willSave == 1) {

        fp = fopen (anw, "w+");

        for (int i = 0;i<100;i++) {
            fprintf(fp, "%c%c" , mine[i] + 80, playfield[i] + 80);
        }
        printf("\nSaved To File!",anw);
        fclose(fp);
    }
    /*else if (willSave == 0){
            fp = fopen (anw, "r");
            fread(code, 200, 1, fp);
            printf("%s\n", code);
            fclose(fp);

    }*/


    if (strcmp(anw, "save")) {
             printf("\Will Save.\n");
        willSave = 1;
    }




}

void printFl() {
    printf("- 0 1 2 3 4 5 6 7 8 9");
}
