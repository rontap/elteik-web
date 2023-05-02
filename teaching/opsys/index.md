# Opsys Gyakorlat

## Linkek

[Canvas](https://canvas.elte.hu/courses/35103)

[Tárgy Honlapja](https://opsys.inf.elte.hu/)

## Adatok

Tárgy neve: Operációs Rendszerek Ea+Gy  
Előadó, Tárgyfelelős, ZH-k és beadandók készítése: Dr Illés Zoltán ( illes@inf.elte.hu ) \
Gyakorlatvezető, Beadandók javítása: Tatai __Áron__ Péter ( g07zoe@inf.elte.hu )

## Időpontok

17.-es kurzus : K:12:00-13:00 (LD 00-503)  _tényleges tervezett időpont: 12:05:12:55_

18.-as kurzus : K:13:00-14:00 (LD 00-503)  _tényleges tervezett időpont: 13:05:13:55_

# Tanterv

## Órák

Az egyes órák anyagát a linkre kattintva lehet megnézni.

1. óra : [Környezet beállítása](prep.md) _Nincs szinkron (jelenléti vagy online) óra_
2. óra : [Ismétlés](gy0.md) (gy0)
3. óra : [Fork](gy1.md) (gy1)
4. óra : [Fork & Basic Signal](gy2.md) (gy2)
5. óra : [Feladatmegoldás, Signal Timer, Sigaction](gy3.md) (gy2)
6. óra : [Signal Timer, Pipe](gy4.md) (gy2 & gy3)
7. óra : [Pipe, FIFO](gy5.md) (gy3)
8. óra : [System V Message Queue & POSIX Message Queue](gy6.md) (gy4)
9. óra : [Ismétlés](gy7.md) - nincs új gyakorlati file
10. óra : [Shared Memory + Semaphore (gy5)](gy8.md) _!! Rákövetkező héten hétfőn Elméleti ZH_
11. óra : Shared Memory + Semaphore (gy6) _!! Rákövetkező héten hétfőn Gyakorlati ZH_
12. óra : Konzultáció, ZH átnézés, lezárás
13. óra : Beadandó Bemutatás

## Letöltések

0 Ismétlés
Anyaga: [Gy0](https://github.com/rontap/elteik-web/raw/main/teaching/opsys/materials/gy0-revision/gy0-opsys.zip)

1 Fork [Gy1](https://github.com/rontap/elteik-web/raw/main/teaching/opsys/materials/gy1/gy1-opsys.zip)

2 // TODO

3 [Gy3](https://github.com/rontap/elteik-web/raw/main/teaching/opsys/materials/gy3/gy03.zip)

4 [Gy3](https://github.com/rontap/elteik-web/raw/main/teaching/opsys/materials/gy4/gy04.zip)

## Számonkérés & Követelmények

### 2 db beadandó.

- [Az első beadandó](bead.md) az első pár óra anyagából.
- [A második beadandó](bead.md)  az első beadandó továbbfejlesztve.   
  A működő és helyes beadandók kellenek a tárgy teljesítéséhez.  
  A beadandót beadás után majd meg kell védeni online,  
  ahol egyszerű elméleti kérdések is fel lesznek téve a
  használt kóddal kapcsolatban.
- A beadandóra jegyet nem kapsz.
- A védés nagyjából 10 percig tart.

### 2 db ZH.

1. Évolyam ZH elméleti, az előadás idejében, 90 perc. Canvas kvíz formájában.
2. Gyakorlat ZH kódolós, az előadás idejében, 90 perc. Online.

## ZH Időpontok

Az első elméleti dolgozat ideje: 2023 május 8, 16 óra (Nappali BSC).   
A dolgozatot Canvas rendszerben kapott elméleti kérdéssor megválaszolásával lehet teljesíteni .  
Az elméleti dolgozat(kvíz) 20 kérdésből áll, aminek megválaszolására 20 perc áll rendelkezésre.
10 helyes választól sikeres a ZH.

A második, gyakorlati dolgozat ideje: 2023 május 15. 16 óra (Nappali BSC)
Tanár
A dolgozat 90 perces.  
A gyakorlati zárthelyi feladatát a feladatok között lehet majd olvasni, és fájlfeltöltéssel a megoldást feltölteni.

PótZH tervezett időpont:  
Elméleti PótZH időpont: 2023 május 22 . 16 óra. Helyszín: Canvas
Gyakorlati PótZH időpont: 2023 május 25. 17.45 óra .

## Példa ZH

Oldja meg az alábbi feladatot C nyelven, ami egy Linux rendszeren tud futni. (Ez lehet a tárgy kiszolgálója (
opsys.inf.elte.hu) vagy egy saját lokális Linux rendszer!) Az eredményt (csak a C forrásfájlt, pl: alma.c) töltse fel
maximum 1.5 óra után a kezdést követően. A feladatokat a gyakorlatvezetők fogják értékelni és az eredményt bejegyzik. A
dolgozat eredménye elégséges ha az első feladat kész, közepes ha az első kettő stb.

A Húsvét elmúlt, és a húsvéti locsoló verseny győztese átveszi a hatalmat és Ő lesz az új "Főnyuszi". Ahogy végigsétál a
birodalmán, látja a tavasz "gyümölcseit", akik vidáman szaladgálnak a frissen kizöldült határban. Elhatározza, hogy "
nyusziszámlálást" kell tartani.

"Főnyuszi" (szülő) nem tart teljes népszámlálást, választ kettőt a területek( Barátfa, Lovas, Kígyós-patak , Káposztás ,
Szula, Malom telek, Páskom) közül, ahova nyuszi számláló biztost (gyerek) küld.

Főnyuszi felkéri a nyuszi számláló biztosokat, Tapsit és Fülest (létrehozza a gyerekeket) és megvárja, amíg a biztosok
felkészülnek a feladatra, amit jelzéssel (tetszőleges) nyugtáznak. Miután főnyuszi fogadta a jelzéseket üzenetsoron
továbbítja mindkét számláló biztosnak a kiválasztott területet, ahol fel kell mérni az állományt. Tapsi is és Füles is
kiírja a feladatul kapott terület-nevet a képernyőre, majd befejezik aznapra a tevékenységüket( terminálnak), amit
Főnyuszi megvár, majd képernyőre írja, hogy Tapsi is és Füles is nyugovóra tért, majd Ő is befejezi aznapra a munkát.
Miután Tapsi és Füles képernyőre írja a kapott terület-nevet, elkezdik a nyuszik számlálását. Az eredményeket (
véletlenszám 50 és 100 között) szintén üzenetsoron küldik vissza Főnyuszinak, aki a képernyőre írja azokat. Főnyuszinak
rendelkezésre áll az előző nyusziszámlálás eredménye (véletlenszám 50 és 100 között minden területre), így rögtön
összehasonlítja, hogy nyuszifogyás vagy gyarapodás történt-e az adott területen, aminek eredményét szintén képernyőre
írja.
Ha nyuszifogyás történt a területen, akkor Főnyuszi "Keress_meg" jelzést, különben "Hazaterhet" jelzést küld Tapsinak és
Fülesnek. Ha "Hazaterhet" jelzést kapott valamelyik biztos, akkor befejezi tevékenységét, ha "Keress_meg" jelzést kap,
akkor újra körbe megy a területen és az új számlálás eredményét (70 és 100 közötti véletlenszám) üzenetsoron újra
visszaküldi, amit Főnyuszi képernyőre ír.
Főnyuszi a két területi minta eredményét osztott memóriába és a képernyőre is kiírja, és ezek alapján állapítsa meg,
hogy népességfogyás vagy gyarapodás volt tapasztalható a nyusziszámlálás során. Az osztott memóriába történő írást védje
szemaforral.
Fordítási utasítások

```shell
gcc -Wall -fsanitize=address -pthread -lrt main.c 
```

### Értékelés

Jegy a következő képpen számolódik:  
`jegy = kerekítés( (elméleti_ZH + gyakorlati_ZH ) / 2 ) - késve_beadott_beadandó`

#### Kerekítés

Ha az alábbiak közül legalább egyet teljesítesz:

- Beadandók alapvető követelményeken túl igényesen írod meg. _(Órán erről részletesen majd beszélünk)_
- Az órát követed, van látható órai munkád.
- Aktívan részt veszel az órán; válaszolsz kérdésekre és esetleg te is kérdezel.

Akkor felfele kerekítem a két ZH átlagát.

#### Késve beadadott beadandó

- Határidő után, de maximum 1 héttel késett feltöltés 1 jegy levonást jelent.
    - A határidő előtt a kérheted a határidő 2 hétre való hosszabbítását.
    - Ha addig sem töltesz fel beadandót, és nem is szólsz róla, akkor nem kaphatsz gyakorlati jegyet!
- A rosszul működő beadandó javításra lesz visszaküldve, de ez a kapott jegyet ez nem
  befolyásolja.
- Ha a több mint két hetet késel bármelyik beadandóddal, vagy a ZH-kat (és pótZH-kat) sem írtad meg, akkor nem
  kaphatsz jegyet (azaz 'nincs érdemjegye' kerül be neptunba).
- Ha a mindkét beadandódat késve adtad be, akkor is **csak egy jegy levonás jár**.

---
`eof`
