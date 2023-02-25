# Opsys Gyakorlat

## Linkek

[Canvas](TODO) // TODO  
[Tárgy Honlapja](https://opsys.inf.elte.hu/)

## Adatok

Tárgy neve: Operációs Rendszerek Ea+Gy  
Előadó, Tárgyfelelős, ZH-k készítése: Dr Illés Zoltán ( illes@inf.elte.hu ) \
Gyakorlatvezető, Beadandók javítása: Tatai __Áron__ Péter ( g07zoe@inf.elte.hu )

## Időpontok

17.-es kurzus : K:12:00-13:00 (LD 00-503)

- _tényleges tervezett időpont: 12:05:12:50_

18.-as kurzus : K:13:00-14:00 (LD 00-503)

- _tényleges tervezett időpont: 13:00:13:45_

# Tanterv

## Órák

*ez egy tervezet, még nem végleges.*
Az egyes órák anyagát a linkre kattintva lehet megnézni.

1. óra : _Elmarad !_
1. óra : Ismétlés (gy0)
2. óra : Fork (gy1)
3. óra : File Descriptors (gy1)
4. óra : Signal (gy2)
5. óra : Pipe (gy3)
6. Beadandó 1 bemutatás
7. óra : Feladat megoldás (gy4)
8. óra : ???
9. Beadandó 2 bemutatás
10. óra : Message Queue (gy5)
11. óra : Shared Memory (gy5)
12. óra : Shm + Szemafor (gy6)

## Számonkérés & Követelmények

### 2 db beadandó.

- Az első beadandó az első pár óra anyagából.
- Az második beadandó az első beadandó továbbfejlesztve.   
  A működő és helyes beadandók kellenek a tárgy teljesítéséhez.  
  A beadandót beadás után majd meg kell védeni online,  
  ahol egyszerű elméleti kérdések is fel lesznek téve a
  használt kóddal kapcsolatban.
- A védés nagyjából 10 percig tart.

### 2 db ZH.

1. Évolyam ZH elméleti, az előadás idejében, 90 perc.
2. Gyakorlat ZH kódolós, az előadás idejében, 90 perc.

### Értékelés

#### Késve beadadott beadandó

- Határidő után, de maximum 1 héttel késett feltöltés 1 jegy levonást jelent.
    - Ez eredeti határidő előtt a hallgató kérheti a határidő 2 hétre való hosszabbítását.
    - Ha addig sem tölt fel beadandót, és nem is szólt róla, akkor nem kaphat gyakorlati jegyet!
- A rosszul működő beadandó javításra lesz visszaküldve, a kapott jegyet ez nem
  befolyásolja.

Ha a hallgató több mint két hetet késett bármelyik beadandóval, vagy a ZH-kat (és pótZH-kat) nem írta meg, akkor nem
kaphat jegyet.

Ha a hallgató mindkét beadandót késve adta be, akkor is csak egy jegy levonás jár.

Jegy a következő képpen számolódik:  
`jegy = kerekítő_függvény( (elméleti_ZH + gyakorlati_ZH ) / 2 ) - kesveBeadottBeadando`

Ahol a kerekítő függvény:

#### Plusz

A beadandókra formai követelmények nincsenek, a beadandó akkor is elfogadásra fog kerülni,
ha rosszul struktúrált, nem lehet a beírt inputokban `space` karakter, stb.

A beadandó elfogadáshoz csak az kell, hogy a kiírt feladatot, és a tárgyon tanult új függvényeket helyesen használjuk.

Viszont a jól olvasható, és továbbfejleszthető kód írását a következő képpen támogatom:

A félév során lehet `+` -okat szerezni. Ha összegyűlik 3 db `+`, akkor a félévi jegy automatikusan felfele kerekítésre
kerül.
Plusz szerzés lehetőségek:

- Ha a beadandó a jó működésen túl még használható kód szempontjából is, kommentekkel van ellátva, stb. (1-1 `+`
  beadandóként)
- Órai aktív munka: Ha részt veszel az órán, kérdéseket teszel fel és a kérdésekre válaszolsz.
- Órai passzív munka: Az órai feladatmegoldásokat követed, le is kódolod magadnál. (Óránként aktív+passzív max 1 `+`)

Vagyis  
`kerekítő_függvény = if (pluszok_száma >= 3) { felfele_kerekít } else { lefele_kerekít }`  


## Kód követelmények
*ez egy tervezet, még nem végleges.*
Egy beadandó csak akkor tekinthető "kész"-nek, ha legalább az alábbi paranccsal lefordul.
Ha valaki olyan kódot ad be, ami még a saját gépén sem fordul, akkor az késésnek számít.

```bash
clang -Wall [FILES]
```

Ahol a `[FILES]` a hallgató által készített fileok. Pl, ha a beadandó file neve az, hogy `bead.c` , akkor a
következőképp nézne ki: `clang -Wall bead.c`.

## Melléklet



--gcc -Wall -pthread -lrt ./*.c