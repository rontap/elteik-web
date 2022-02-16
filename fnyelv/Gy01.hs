{-
- Gyak felvételek: Teams->tárgy team->gyakX->files

- canvas EA oldal: tematika + összes info
 - követelmény:
   - gyak: minimum követelmény: 13 pont
     - órai eleji kisfeladat: 0-2 pont (10 perc)
     - nagy házi feladat: félév során 3 darab, 4-4 pontért
        - első hf félév közepén van kiírva
        - mindegyik határideje: vizsgaidőszak eleje
     - canvas-ra egy .hs fájlt kell feltölteni
   - vizsga:
     - jegy ebből származik
     - 2 órás, feladatmegoldás
   - jelenlét:
     - max 4 hiányzás
     - óra eleji feladat számít jelenlétnek (távoktatásban!)(üresen is küldjétek be a feladatot!)
       - jelenléti oktatás: jelenlét számít jelenlétnek

- Távoktatás vs jelenléti oktatás?

  - min 3 hétig táv, utána valamikor váltunk
    (szerintem félév nagy részében jelenlét lesz)

- Önálló feladatmegoldás: képernyőt osszatok
- Ha valaki el van maradva: lambda.inf.elte.hu kezdő Haskell jegyzet
                            Learn you a Haskell! könyv, stb.

- Előzetes ismeretek:
  - BSc "funkcionális programozás" ismerete (készség szinten)
    (lambda.inf.elte.hu "Kezdő Haskell" jegyzet ajánlott)

Következő kisfeladat:
  - nagyon egyszerű: lényeg, hogy canvas-ba feladatot feltöltse mindenki

Feladatok, technika, ismétlés
  - ghci parancsok
    :l <fájl>       betöltés
    :r              újratöltés
    :t <kifejezés>  kifejezés típusát megadja
    :i <azonosító>  információt ír ki (operátorról is)
-}


--------------------------------------------------------------------------------

{-# options_ghc -Wincomplete-patterns #-}
module Gy01 where


-- Gyakorló feladatok (ismétlés, függvények, mintaillesztés, ADT-k, osztályok)
--------------------------------------------------------------------------------
-- Definiáld a "xor" műveletet Bool típuson. Használj mintaillesztést,
-- vagy Prelude-ből standard függvényt.
xor :: Bool -> Bool -> Bool
xor = (/=)

-- case of

-- let ... in ...

-- ... where ...

-- függvények
--------------------------------------------------------------------------------

-- Definiáld a következő függvényeket tetszőlegesen, de
-- típushelyesen és totális függvényként (azaz nem lehet végtelen loop
-- vagy kivétel dobás!).
f1 :: (a, (b, (c, d))) -> (b, c)
-- f1 p = ()
f1 p = (fst (snd p) , fst (snd (snd p)))

f2 :: (a -> b) -> a -> b
f2 f a = f a

-- f2menőbb:
--f2' f = f
--f2'' = ($)
--f2''' = id

f3 :: (b -> c) -> (a -> b) -> a -> c
f3 f g a = f (g a)

f3' :: (b -> c) -> (a -> b) -> (a -> c)
f3' f g = f . g
f3'' = (.)

f4 :: (a -> b -> c) -> b -> a -> c
f4 f g a = f a g
f4' = flip

f5 :: ((a, b) -> c) -> a -> b -> c
f5 f a b = f (a,b)
f5' = curry

f6 :: (a -> b -> c) -> (a, b) -> c
f6 f (a,b) = f a b


-- inline lambda xor = \a -> \b = ...
--

--f7 :: (a -> (b, c)) -> (a -> b, a -> c)
--f7 f = ( \a -> fst f a , \a -> snd f a )

--f8 :: (a -> b, a -> c) -> (a -> (b, c))
f8 :: (a -> b, a -> c) -> a -> (b, c)
f8 (f,g) a = (f a, g a)

f9 :: (Either a b -> c) -> (a -> c, b -> c)
f9 f = ( \a -> f (Left a) , \b -> f (Right b))

f10 :: (a -> c, b -> c) -> (Either a b -> c)
f10 = undefined

f11 :: Either (a, b) (a, c) -> (a, Either b c)
f11 = undefined

f12 :: (a, Either b c) -> Either (a, b) (a, c)
f12 = undefined

-- bónusz feladat (nehéz)
f13 :: (a -> a -> b) -> ((a -> b) -> a) -> b
f13 = undefined


-- listák
--------------------------------------------------------------------------------

-- Írj egy "applyMany :: [a -> b] -> a -> [b]" függvényt, ami egy
-- listában található minden függvényt alkalmaz egy
-- értékre. Pl. "applyMany [(+10), (*10)] 10 == [20, 100]".
-- applyMany :: [a -> b] -> a -> [b]
-- applyMany = undefined

applyMany :: [a -> b] -> a -> [b]
applyMany = undefined


-- Definiálj egy "NonEmptyList a" típust, akár ADT-ként, akár
-- típusszinonímaként, aminek az értékei nemüres listák.

--   - Írj egy "toList :: NonEmptyList a -> [a]" függvényt!

--   - Írj egy "fromList :: [a] -> Maybe (NonEmptyList a)" függvényt, ami
--     nemüres listát ad vissza egy standard listából, ha az input nem
--     üres.


-- Definiáld a "composeAll :: [a -> a] -> a -> a" függvényt. Az eredmény legyen
-- az összes bemenő függvény kompozíciója,
-- pl. "composeAll [f, g, h] x == f (g (h x))"
composeAll :: [a -> a] -> a -> a
composeAll = undefined


-- Definiáld a "merge :: Ord a => [a] -> [a] -> [a]" függvényt, ami két nemcsökkenő
-- rendezett listát összefésül úgy, hogy az eredmény is rendezett maradjon.
merge :: Ord a => [a] -> [a] -> [a]
merge = undefined


-- (bónusz) Definiáld a "mergeSort :: Ord a => [a] -> [a]" függvényt, ami a "merge"
-- iterált felhasználásával rendez egy listát.
mergeSort :: Ord a => [a] -> [a]
mergeSort = undefined


-- (bónusz) Definiáld a "sublists :: [a] -> [[a]]" függvényt, ami a bemenő lista
-- minden lehetséges részlistáját visszaadja. Pl. "sublists [1, 2] == [[],
-- [1], [2], [1, 2]]".  A részlisták sorrendje az eredményben tetszőleges, a
-- fontos, hogy az össze részlista szerepeljen.
-- Kapcsolódó fogalom: hatványhalmaz
sublists :: [a] -> [[a]]
sublists = undefined


-- osztályok
--------------------------------------------------------------------------------

class Eq' a where
  eq :: a -> a -> Bool

class Eq' a => Ord' a where
  lte :: a -> a -> Bool

class Show' a where
  show' :: a -> String

data Tree a = Leaf a | Node (Tree a) (Tree a)
data Color = Red | Green | Blue

-- írd meg a következő instance-okat
instance Eq' Color where
  eq = undefined

instance Ord' Color where
  lte = undefined

instance Show' Color where
  show' = undefined

instance Eq' a => Eq' (Maybe a) where
  eq = undefined

instance Ord' a => Ord' (Maybe a) where
  lte = undefined

instance Show' a => Show' (Maybe a) where
  show' = undefined

instance Eq' a => Eq' [a] where
  eq = undefined

instance Ord' a => Ord' [a] where
  lte = undefined

instance Show' a => Show' [a] where
  show' = undefined

instance Eq' a => Eq' (Tree a) where
  eq = undefined

instance Ord' a => Ord' (Tree a) where
  lte = undefined

instance Show' a => Show' (Tree a) where
  show' = undefined