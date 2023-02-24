# Opsys Gyakorlat

## Adatok

Tárgy neve: Operációs Rendszerek Ea+Gy  
Előadó, Tárgyfelelős, ZH-k készítése: Dr Illés Zoltán ( illes@inf.elte.hu ) \
Gyakorlatvezető, Beadandók javítása: Tatai __Áron__ Péter ( g07zoe@inf.elte.hu )

[Tárgy Honlapja](https://opsys.inf.elte.hu/)

## Időpontok

17.-es kurzus : K:12:00-13:00 (LD 00-503)

- _tényleges tervezett időpont: 12:05:12:50_

18.-as kurzus : K:13:00-14:00 (LD 00-503)

- _tényleges tervezett időpont: 13:00:13:45_

# Tanterv (??)

## Számonkérés & Követelmények

### 2 db beadandó.

- Az első pár óra anyagából.
- Az második beadandó az első beadandó továbbfejlesztve.   
  A működő és helyes beadandók kellenek a tárgy teljesítéséhez.  
  A beadandót beadás után meg kell védeni,  
  ahol egyszerű elméleti kérdések is fel lesznek téve a
  használt kóddal kapcsolatban.   
  A védés nagyjából 10-15 percig tart, ahol a hallgatónak előszőr kell magyarázni a programja működését.
- Késve beadadott beadandó:
    - Határidő után maximum 1 héttel való késett feltöltés 1 jegy levonást jelent.
        - Ez eredeti határidő előtt a hallgató kérheti (jogos indokkal) a határidő 2 hétre való hosszabbítását.
    - Ha addig sem tölt fel beadandót, akkor nem kaphat gyakorlati jegyet!
    - A nem hibátlanul működő beadandó javításra lesz visszaküldve, a kapott jegyet ez nem
      befolyásolja.

### 2 db ZH.

1. Évolyam ZH elméleti, az előadás idejében, 90 perc.
2. Gyakorlat ZH kódolós, az előadás idejében, 90 perc.

### Értékelés

Ha a hallgató több mint egy hetet késett bármelyik beadandóval, vagy a ZH-kat (és pótZH-kat) nem írta meg, akkor nem
kaphat jegyet.

`jegy = felfele_kerekít( (elméleti_ZH + gyakorlati_ZH ) / 2 ) - kesveBeadottBeadando`

Ha a hallgató mindkét beadandót késve adta be, akkor is csak egy jegy levonás jár.  
Pl:

## Órák

*ez egy tervezet, még nem végleges.*

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

## Kód követelmények

Egy beadandó csak akkor tekinthető "kész"-nek, ha az alábbi környezetben legalább lefordul.
Ha valaki olyan kódot ad be, ami még a saját gépén sem fordul, akkor az késésnek számít.

```bash
clang -Wall [FILES]
```

Ahol a `[FILES]` a hallgató által készített fileok. Pl, ha a beadandó file neve az, hogy `bead.c` , akkor a
következőképp nézne ki: `clang -Wall bead.c`.

### Melléklet

#### Jegyszerzés Példák

| Elméleti ZH | Gyakorlati ZH | Beadandó 1          | Beadandó 2   | Végső jegy        |
|-------------|---------------|---------------------|--------------|-------------------|
| 5           | 4             | időben              | időben       | 5                 |
| 3           | 4             | időben              | <1 hét késés | 3                 |
| 3           | 3             | <1 hét késés        | <1 hét késés | 2                 |
| 5           | 5             | 1 hétnél több késés | időben       | nem kaphat jegyet |

--gcc -Wall -pthread -lrt ./*.c