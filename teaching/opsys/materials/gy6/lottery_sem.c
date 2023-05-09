//
// Created by rontap on 01/05/2023.
//
#include "libopsys.h"


#pragma clang diagnostic push
#pragma ide diagnostic ignored "EndlessLoop"

// shared memory size to allocate
#define MEMSIZE 500
// ASCII table (char) -> (int)
#define SHIFT_TO_NUMBER 48
// ASCII \n (LF - Line feed) character code.
#define LINE_BREAK (SHIFT_TO_NUMBER - 10)

int create_semaphore(const char *path, int sem_value) {
    int sem_id;
    key_t key;

    key = ftok(path, 4);
    if ((sem_id = semget(key, 1, IPC_CREAT | S_IRUSR | S_IWUSR)) < 0)
        perror("semget");

    // semget 2. parameter is the number of semaphores
    if (semctl(sem_id, 0, SETVAL, sem_value) < 0)    //0= first semaphores
        perror("semctl");
    return sem_id;
}

void modify_semaphore(int semid, int operation) {
    struct sembuf axrion;

    axrion.sem_num = 0;
    axrion.sem_op = (short) operation; // operation=1 up, operation=-1 down
    axrion.sem_flg = 0;

    if (semop(semid, &axrion, 1) < 0) // 1 number of sem. operations
        perror("semop");
}


void get_random(char *str) {
    int rn[5];
    rn[0] = rand() % 100;
    rn[1] = rand() % 100;
    rn[2] = rand() % 100;
    rn[3] = rand() % 100;
    rn[4] = rand() % 100;
    sprintf(str, "num [%d %d %d %d %d]", rn[0], rn[1], rn[2], rn[3], rn[3]);
}

int get_shm_mem(int shm_key) {
    int sh_id = shmget(shm_key, MEMSIZE, IPC_CREAT | S_IRUSR | S_IWUSR);
    printf("\n =>> Assigning shared memory. Segment: %i", sh_id);
    return sh_id;
}

int write_shm_mem(int shm_id, bool slow_mode) {
    // Attaching shared memory
    char *shared_arr = shmat(shm_id, NULL, 0);
    printf("\n =>> Shared memory Contents: [%s]", shared_arr);
    char buffer[40];
    get_random(buffer);
    printf("\n =>> Writing new content: [%s]", buffer);

    if (slow_mode) {
        printf("\n =>> Writing slowly: ");
        sleep(1);
        for (int i = 0; buffer[i]; i++) {
            sleep(1);
            printf("%c", buffer[i]);
            fflush(stdout);
            shared_arr[i] = buffer[i];
        }
        printf("\n =>> Writing slowly over");

    } else {
        strcpy(shared_arr, buffer);
    }

    // Detaching Shared memory
    shmdt(shared_arr);
    //	shared_arr[0]='B';  //ez segmentation fault hibat ad
    return 0;
}

// NEW
int write_shm_mem_sem(int shm_id, int sem_id) {
    printf("\n =>> Waiting for semaphore");
    sleep(1);
    modify_semaphore(sem_id, -1);

    // Attaching shared memory
    char *shared_arr = shmat(shm_id, NULL, 0);
    printf("\n =>> Shared memory Contents: [%s]", shared_arr);
    char buffer[40];
    get_random(buffer);
    printf("\n =>> Writing new content: [%s]", buffer);

    // writing to shared memory
    printf("\n =>> Writing slowly: ");
    for (int i = 0; buffer[i]; i++) {
        sleep(1);
        printf("%c", buffer[i]);
        fflush(stdout);
        shared_arr[i] = buffer[i];
    }

    printf("\n =>> Unlocking semaphore for semaphore");
    // detaching shared memory
    shmdt(shared_arr);
    modify_semaphore(sem_id, 1);

    return 0;
}
// END NEW

int read_shm_mem(int shm_id) {
    char *shared_arr = shmat(shm_id, NULL, 0);
    printf("\n =>> Shared memory Contents: [%s]", shared_arr);
    shmdt(shared_arr); // ~ free(..)
    return 0;
}

int remove_shm_mem(int shm_id) {
    printf("\n =>> Freeing up shared memory.");
    shmctl(shm_id, IPC_RMID, NULL);
    return 0;
}


int main(int argc, char *argv[]) {
    srand(time(NULL));

    printf("\n=== Shared Memory Example (arg: %s) ===\n", argv[1]);
    printf("\n=== 1.) Reserve Shm");
    printf("\n=== 2.) Write Lottery Numbers to Shm");
    printf("\n=== 3.) Write Lottery Numbers Slowly ");
    printf("\n=== 4.) Read Lottery Numbers");
    printf("\n=== 5.) Read Lottery Numbers every 1 sec");
    printf("\n=== 6.) Free up Shm");
    printf("\n=== === New Function for Semaphores:");
    printf("\n=== 7.) Write Lottery Numbers Slowly (Semaphore)");
    printf("\n=== 0.) Exit");
    int option;

    key_t shm_key = ftok(argv[0], 1);
    printf("\n=>> Shared Memory Key: %i %s", shm_key, argv[0]); // key is based on filename

    // NEW
    int sem_id = create_semaphore(argv[0], 1);
    // END NEW

    int shared_mem_id = -1;

    while (1) {
        printf("\nGive an option between 1-6  >");
        option = (int) getc(stdin) - SHIFT_TO_NUMBER;
        if (option != LINE_BREAK) getc(stdin);

        switch (option) {
            case 1:
                shared_mem_id = get_shm_mem(shm_key);
                break;
            case 2:
                write_shm_mem(shared_mem_id, false);
                break;
            case 3:
                write_shm_mem(shared_mem_id, true);
                break;
            case 4:
                read_shm_mem(shared_mem_id);
                break;
            case 5:
                while (1) {
                    sleep(1);
                    read_shm_mem(shared_mem_id);
                }
                break;
            case 6:
                remove_shm_mem(shared_mem_id);
                break;
            case 7:
                write_shm_mem_sem(shared_mem_id, sem_id);
                break;
            case 0:
                printf("\nExiting.");
                exit(0);
            default:
                printf("\nInvalid option.");
                break;
        }
    }
}


#pragma clang diagnostic pop