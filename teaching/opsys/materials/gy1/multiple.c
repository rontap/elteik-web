#include "libopsys.h"

int main() {
    for (int i = 0; i < 5; i++) {
        fork();
    }
    printf("hi");
}