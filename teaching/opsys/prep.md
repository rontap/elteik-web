# Opsys Gyakorlat / 1. Óra : Előkészületek

[Vissza](index.md)

---
Utolsó frissítés: Március 7.

---
Az első megtartott óráig kérlek állítsátok össze a fejlesztő környezeteteket.  
Ha esetleg elakadtok, nyugodtan kérdezzetek teams-en.

## 1.: Fordító telepítése

Unix-Szerű környezet (Linux, MacOS, WSL) kell
a tárgy feladatainak a megoldásához.  
A gyakorlatokon `C`-ben fogunk programozni.   
Ehhez szűkséges a `gcc` fordító csomag felrakása.

### Linux & Mac

A `gcc` / `clang` C nyelv fordítónak el kéne lenne telepítve, terminálból ellenőrizhetitek ezt.: `gcc --version` 

### Windows

**Ajánlott módszer:**  
WSL (Windows Subsystem for Linux) telepítése.
Ez a Microsoft által kiadott alrendszer lehetővé teszi a
tárgy keretében lévő összes Unix/Linux specifikus feladat megoldását.  
Hivatalos telepítési útmutató:
[https://learn.microsoft.com/en-us/windows/wsl/install](https://learn.microsoft.com/en-us/windows/wsl/install)

Telepítés után a windows parancssorból a `wsl` parancs
segítségével be tudtok lépni a linuxos környezetbe.  
És a `cd /mnt/c`-vel pedig a C meghajtótokhoz is hozzáférhettek.  
A file-okat windows alól ugyanúgy megnyithatjátok és szerkeszthetitek, csak a fordításhoz és futtatáshoz kell majd a wsl

**Replit:**  
A kódok eléggé egyszerűek ahhoz, hogy online felületen is lehessen szerkeszteni.
Ha több gép között járkálsz, esetleg a géped nem támogatja a WSL-t, akkor ezzel jársz a legjobban.
Hátránya, hogy eléggé lassú.  
[https://replit.com/](https://replit.com/)

**Opsys szerver:**  
A tárgynak van egy dedikált szervere is `opsys.inf.elte.hu`, ahova a következő parannccsal tudtok be ssh-zni:
`ssh username@opsys.inf.elte.hu`

Ahol a username a ELTE Caesar usernevetek.
Ezt az opciót **kifejezetten nem ajánlom**, mert ZH alatt mindig problémák vannak a
a szerverrel. Csak a teljesség kedvéért említem.

> **Megjegyzés:**  
> Nem elég simán windows-os C compilert használni (pl mingw, msvc++), specifikusan Unix/Linux környezet kell.

## 2.: IDE választása

Természetesen olyan IDE-t használtok, amit szeretnétek. Ez már csak személyes ajánlás.

- [VScode](https://code.visualstudio.com/) - Könnyű és gyors IDE.
- [CLion](https://www.jetbrains.com/clion/) - Ha ismered az IntelliJ-t, akkor ideális választás.
  Sokkal teljeskörűbb támogatást ad, mint a Vscode. ELTE-s diákként jár licence hozzá.

> **Megjegyzés:**
> Code::Blocks-ot kifejezetten nem ajánlom. A beadandó bemutatásakor terminálból kell fordítani majd a kódot,
> és ez problémát okozhat, ha Code::Blocks-ban teszteled csak a kódot.
---

## 3.: Egyszerű teszt

Nézzétek meg, hogy tudtok-e ténylegesen kódot fordítani, például hozzatok létre egy `test.c` file-t ezzel a tartalommal:

```c
#include <stdio.h>
#include <sys/wait.h>
#include <sys/ipc.h>
#include <sys/shm.h>
int main() {
    printf("Hello World \n");
    return 0;
}
```

És fordítsátok le (és futtassátok) az alábbi paranccsal:

```shell
 gcc -Wall -Werror=vla -pthread -lrt -std=c11 -pedantic ./test.c  && ./a.out 
```

OS/X-en pedig:

```shell
 clang -Wall -Werror=vla -pthread -std=c11 -pedantic -o a.out ./test.c && ./a.out
```

Ha WSL-ben nem sikerül a gcc-t használni, futtassátok ezt:
```shell
sudo apt upgrade
sudo apt update
sudo apt install
```

Ha mindenféle hiba nélkül egy sima hello world-öt láttok, **akkor kész vagytok**, a gyakorlat anyagát tudjátok majd
saját gépen is követni.  
**Ha a kód nem fordul, írjatok teams-en és próbálok segíteni.**


> **Megjegyzés:**
> MacOS-en `gcc` helyett `clang`-ot érdemes használni.

---

[Kezdőlap](index.md)
|
[Tovább](gy0.md)
