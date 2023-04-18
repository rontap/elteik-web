# 7. Óra / Gy05 / Message Queue

## [Új Fileok letöltése](https://github.com/rontap/elteik-web/raw/main/teaching/opsys/materials/gy4/gy04.zip)

[https://github.com/rontap/elteik-web/raw/main/teaching/opsys/materials/gy4/gy04.zip](https://github.com/rontap/elteik-web/raw/main/teaching/opsys/materials/gy4/gy04.zip)

---
[Kezdőlap](index.md)
|
[Vissza](gy5.md)
|
[Tovább](gy7.md)

| Témakör                     | Adattípus                                   | Létrehozás                           | Módosítás                                                                                                  | Írás  / Küldés                               | Várakozás                           | Olvasás  / Fogadás                                                                                                                                         | Bezárás               |
|-----------------------------|---------------------------------------------|--------------------------------------|------------------------------------------------------------------------------------------------------------|----------------------------------------------|-------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------|
| File                        | `f FILE*`                                   | `f = fopen`<br/>`( char*, int mode)` | keresés `lseek`<br/>`(f, 0, SEEK_SET)`                                                                     | `fwrite`<br/>`(&c, sizeof(c), sizeof(c), f)` |                                     | `fread`<br/>`(&c, sizeof(c), sizeof(c), f)`                                                                                                                | `fclose`<br/>`( f ) ` |
| Fork                        | `pid_t` = int <br/> 0 = child , >0 = parent | `pid = fork()`                       | új processz, visszatér<br/>`system( char** exec )`<br/>nem tér vissza<br/>`execv(char* exec, char** args)` |                                              | `waitpid`<br/>`(child, &status, 0)` | pid lekérdezése (szülő, saját) `getppid()`<br/>`getpid()`                                                                                                  |
| Signal                      | `struct sigaction`<br/>`struct sigset`      |                                      | `sigemptyset(&sigset)`<br/>`sigfillset(&sigset)`<br/>`sigdelset(&sigset, SIGTERM)`                         | `kill( pid, signal)`                         | `pause()`<br/>`sigsuspend(&sigset)` | `sigaction.handler` =<br/> `void handler(int signumber)`<br/>`sigaction(signal, &sigaction, NULL)`<br/>`sigprocmask(SIG_UNBLOCK, &sigset, NULL);  ` |                       |
| Signal Timers               |                                             |                                      |                                                                                                            |                                              |                                     |                                                                                                                                                            |                       |
| Pipes                       |                                             |                                      |                                                                                                            |                                              |                                     |                                                                                                                                                            |                       |
| Pipe                        |                                             |                                      |                                                                                                            |                                              |                                     |                                                                                                                                                            |                       |
| Poll                        |                                             |                                      |                                                                                                            |                                              |                                     |                                                                                                                                                            |                       |
| System-V <br/>Message Queue |                                             |                                      |                                                                                                            |                                              |                                     |                                                                                                                                                            |                       |
| POSIX Message Queue         |                                             |                                      |                                                                                                            |                                              |                                     |                                                                                                                                                            |                       |
|                             |                                             |                                      |                                                                                                            |                                              |                                     |                                                                                                                                                            |                       |

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
