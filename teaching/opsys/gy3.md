# 5. Óra / Gy02 / Signal

## [Fileok letöltése](https://github.com/rontap/elteik-web/raw/main/teaching/opsys/materials/gy2/gy02.zip)

[https://github.com/rontap/elteik-web/raw/main/teaching/opsys/materials/gy2/gy02.zip](https://github.com/rontap/elteik-web/raw/main/teaching/opsys/materials/gy2/gy02.zip)

---
[Kezdőlap](index.md)
|
[Vissza](gy2.md)[libopsys.h](materials%2Fgy1%2Flibopsys.h)
|
[Tovább](gy4.md)

### Letöltés: ugyanaz mint előző órán : gy02

## Előzőr részek tartalmából: Signal

`Signal` = Jel egy processből a másikba.  
Fontosabb signalok: `SIGKILL, SIGSEGV, SIGIO, SIGTERM, SIGINT`. Ezek igazából számok, Signalok 1..32 között.

### Signal Küldés

PID = Process ID, a proessz egyedi azonosítója
Például a szülő program megölése:

```c
pid_t pid = getppid();
kill(pid,SIGTERM);
```

### Signal Handler (sigacion)

Egy nem 'elkapott' signal leállítja a processt.
Ahhoz, hogy egy process lekezelje a signalt, a következőt kell beállítani:

```c
void handler(int signumber) {
printf("[handler] %i\n", signumber);
}

struct sigaction sigact;
sigact.sa_handler = handler; 
sigemptyset(&sigact.sa_mask);
sigact.sa_flags = 0; 

sigaction(SIGTERM, &sigact, NULL);
```

Itt a `SIGTERM` signal nem leálltja az alkalmazást, hanem meghívja a handlert. Miután a handler lefutott, folyik a
program futása.  
Vannak signalok, amiket nem lehet 'elkapni', ilyen pl a `SIGKILL`.

### Signal Suspend (sleep -> sigsuspend)

A fogadó oldalon lehet 'várni' egy signalra. A `pause()` egy általános várakozás,
minden signal felébreszti.
A `sigsuspend(&sigset)` kap egy signal halmazt.
Azok az elemek, amik nincsenek benne, azokra felébred. A többinél vár tovább.

Példa sigsuspendre, ami csak a `SIGTERM`-re ébred fel:

```c
sigset_t sigset;
sigfillset(&sigset);
sigdelset(&sigset, SIGTERM);
sigsuspend(&sigset);
```

### Ezen az órán
- Órai feladat befejezése
- Még egy maskolási lehetőség
- Adat küldése signallal

## Fileok fordítása

```shell
 gcc -Wall -Werror=vla -pthread -lrt -std=c11 -pedantic -o a.out ./signal.c && ./a.out 
```

OS/X-en pedig:

```shell
 clang -Wall -Werror=vla -pthread -std=c11 -pedantic -o a.out ./signal.c && ./a.out 
```

## Óra Outline

- [ ] 15 min két részre oszlás
    1. Alapoktól újrakezdés
    2. Feladatmegoldás folytatása
- [ ] 15 min közös átbeszélése a feladatnak
- [ ] `sigprocmask.c`
- [ ] [sigaction_value.c](materials%2Fgy2%2Fsigaction_value.c)`raise` , `setitimer.c`

## `Kill.c`
Plusz feladat:
A kill sikerességétől függetlenül
írjuk ki egy kill.log
file-ba az alábbi formájú sort:
`IDŐ USER SIGNAL PID ERRNO`
Ahol:
- Idő: unix system time, vagy hasonló
- User: user name aki a parancsot kiadta
- Signal: signal amit a user megadott
- Pid: pid amit a user megadott
- Errno: A fork-olás errno-ja, 0 ha sikeres.

[Kezdőlap](index.md)
|
[Vissza](gy1.md)
|
[Tovább](gy3.md)
