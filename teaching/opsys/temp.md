
---

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



--gcc -Wall -Werror=vla -pthread -lrt ./*.c




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
