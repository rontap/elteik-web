# 6. Óra / Gy02 / Gy03 / Timer & Pipe

## [Új Fileok letöltése](https://github.com/rontap/elteik-web/raw/main/teaching/opsys/materials/gy3/gy03.zip)

[https://github.com/rontap/elteik-web/raw/main/teaching/opsys/materials/gy3/gy03.zip](https://github.com/rontap/elteik-web/raw/main/teaching/opsys/materials/gy3/gy03.zip)

---
[Kezdőlap](index.md)
|
[Vissza](gy3.md)
|
[Tovább](gy5.md)

## Előzőr részek tartalmából: Signal

`Signal` = Jel egy processből a másikba.  
Fontosabb signalok: `SIGKILL, SIGSEGV, SIGIO, SIGTERM, SIGINT`. Ezek igazából számok, Signalok 1..32 között.

## Fileok fordítása

```shell
 gcc -Wall -Werror=vla -pthread -std=c11 -pedantic -o a.out ./signal.c -lrt  && ./a.out 
```

OS/X-en pedig:

```shell
 clang -Wall -Werror=vla -pthread -std=c11 -pedantic -o a.out ./signal.c  && ./a.out 
```

## Óra Outline

- [ ] `setitimer.c` , `sigaction_value.c`
- [ ] `sigprocmask.c`
- [ ] `pipe.c` -> write?
- [ ] ps aux, std, file all

[Kezdőlap](index.md)
|
[Vissza](gy3.md)
|
[Tovább](gy5.md)
