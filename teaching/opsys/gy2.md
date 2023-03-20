# 4. Óra / Gy1 & Gy2 / Fork & Signal

## [Fileok letöltése](https://github.com/rontap/elteik-web/raw/main/teaching/opsys/materials/gy2/gy02.zip)

[https://github.com/rontap/elteik-web/raw/main/teaching/opsys/materials/gy2/gy02.zip](https://github.com/rontap/elteik-web/raw/main/teaching/opsys/materials/gy2/gy02.zip)

---
[Kezdőlap](index.md)
|
[Vissza](gy1.md)
|
[Tovább](gy3.md)

## Fileok fordítása

```shell
 gcc -Wall -Werror=vla -pthread -lrt -std=c11 -pedantic -o a.out ./signal.c && ./a.out 
```

OS/X-en pedig:

```shell
 clang -Wall -Werror=vla -pthread -std=c11 -pedantic -o a.out ./signal.c && ./a.out 
```

## Óra Outline

- [ ] Jelenlét, beadandó védés
- [ ] Fcntl befejezés
- [ ] fork (child) rajzolás
- [ ] hogyan küldünk signaolokat `gy2 signal.c`
- [ ] rendes signalok `gy2 sigaction.c`
- [ ] Feladat megoldás `killable.c` 15 min
    - CTRL ^ c miért nem megy?
    - Stack fault (no handler!)
- [ ] Beadandó I. Alapok (ha belefér)

[Kezdőlap](index.md)
|
[Vissza](gy1.md)
|
[Tovább](gy3.md)
