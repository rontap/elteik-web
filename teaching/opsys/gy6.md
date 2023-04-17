# 7. Óra / Gy05 / Message Queue

## [Új Fileok letöltése](https://github.com/rontap/elteik-web/raw/main/teaching/opsys/materials/gy5/gy05.zip)

[https://github.com/rontap/elteik-web/raw/main/teaching/opsys/materials/gy5/gy05.zip](https://github.com/rontap/elteik-web/raw/main/teaching/opsys/materials/gy5/gy05.zip)

---
[Kezdőlap](index.md)
|
[Vissza](gy5.md)
|
[Tovább](gy7.md)

## Előző részek tartalmából

pipe

## Fileok fordítása

```shell
 gcc -Wall -Werror=vla -pthread -std=c11 -pedantic -o a.out ./signal.c -lrt  && ./a.out 
```

OS/X-en pedig:

```shell
 clang -Wall -Werror=vla -pthread -std=c11 -pedantic -o a.out ./signal.c  && ./a.out 
```

## Óra Outline

- [ ] -lrt .dll
- [ ] System V message queues rajz
- [ ] System V message queues kód nézés
- [ ] POSIX MQ
- [ ] Miért van mindig két impl?



[https://en.wikipedia.org/wiki/Unix_wars#/media/File:Unix_timeline.en.svg]()

[Kezdőlap](index.md)
|
[Vissza](gy5.md)
|
[Tovább](gy7.md)
