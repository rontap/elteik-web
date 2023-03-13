# 2. Óra / Gy1 / Fork

## [Fileok letöltése](https://github.com/rontap/elteik-web/raw/main/teaching/opsys/materials/gy1/gy1.zip)

[https://github.com/rontap/elteik-web/raw/main/teaching/opsys/materials/gy0-revision/gy0-opsys.zip](https://github.com/rontap/elteik-web/raw/main/teaching/opsys/materials/gy1/gy1.zip)

## Fileok fordítása

```shell
 gcc -Wall -Werror=vla -pthread -lrt -std=c11 -pedantic -o a.out ./open_fopen.c && ./a.out text.txt
```

OS/X-en pedig:

```shell
 clang -Wall -Werror=vla -pthread -std=c11 -pedantic -o a.out ./open_fopen.c && ./a.out text.txt
```

### Előző részek tartalmából

| Header                 | Mit csinál                 |
|------------------------|----------------------------|
| `#include <stdlib.h>`  | `rand, malloc, atoi, exit` |
| `#include <stdio.h>`   | `feof, fopen, scanf, puts` |
| `#include <string.h>`  | `strlen, strrchr, strtok`  |
| `#include <stdbool.h>` | `bool` típus               |

### Új headerek

| Header                   | Mit csinál                    |
|--------------------------|-------------------------------|
| `#include <unistd.h>`    | `fork, rmdir` util függvények |
| `#include <sys/wait.h>`  | `waitpid`  no windows         |
| `#include <fcntl.h>`     | File CoNTroL `open, fcntl`    |
| `#include <sys/types.h>` | konstansok                    |
| `#include <sys/stat.h>`  | File info                     |

## Óra Outline


- [ ] Katalógus
- [ ] Új headerek `rand.c` srand!
- [ ] `fork.c`, Fork bomb, recursive fork
- [ ] `random`
- [ ] `write.c` -> `system.c` -> `exec.c`
- [ ] `fcntl_0.c`
- [ ] Fixing `fcntl.c`
- [ ] _opcionális_ gy2 signal intro 

## Opcionális telepítendő dolgok

[Kezdőlap](index.md)
|
[Vissza](gy0.md)
|
[Tovább](gy2.md)
