# Opsys Gyakorlat / 1. Óra : Előkészületek

[Vissza]()

---


## Programozási környezet

Unix-Szerű környzet (Linux, MacOS, WSL) kell
a tárgy feladatainak a megoldásához.

Az első megtartott óráig kérlek állítsátok össze a fejlesztő környezeteteket.

#### Linux & Mac

A `gcc` / `clang` C nyelv fordítónak el kéne lenne telepítve, terminálból ellenőrizhetitek ezt.

#### Windows

**Ajánlott módszer:**  
WSL (Windows Subsystem for Linux) telepítése.
Ez a Microsoft által kiadott alrendszer lehetővé teszi a
tárgy keretében lévő összes Unix/Linux specifikus feladat megoldását.  
Hivatalos telepítési útmutató:
[https://learn.microsoft.com/en-us/windows/wsl/install](https://learn.microsoft.com/en-us/windows/wsl/install)

Telepítés után a windows parancssorból a `wsl` parancs
segítségével be tudtok lépni a linuxos környezetbe.  
És a `cd /mnt/c`-vel pedig a C meghajtótokhoz is hozzáférhettek.

**Replit:**
A kódok eléggé egyszerűek ahhoz, hogy online felületen is lehessen szerkeszteni.
Ha több gép között járkálsz, esetleg a géped nem támogatja a WSL-t, akkor ezzel jársz a legjobban.

[https://replit.com/](https://replit.com/)

**Opsys szerver:**  
A tárgynak van egy dedikált szervere is `opsys.inf.elte.hu`, ahova a következő parannccsal tudtok be ssh-zni:
```shell
ssh username@opsys.inf.elte.hu
```
Ahol a username a ELTE Caesar usernevetek.
Ezt az opciók **kifejezetten nem ajánlom**, mert ZH alatt mindig problémák vannak a 
a szerverrel. Csak a teljesség kedvéért említem.


---

[Vissza]()