{-# options_ghc -Wincomplete-patterns #-}
module Gy02 where

f7 :: (a -> (b, c)) -> (a -> b, a -> c)
--f7 f = (\a -> fst (f a), \a -> snd (f a))
--szépítve:
f7 f = (fst . f, snd . f)

f8 :: (a -> b, a -> c) -> (a -> (b, c))
--amúgy is jobbra lenne zárójelezve
f8 (f,g) = \a -> (f a , g a)

data Maybe' a = Nothing' | Just' a
maybeInt :: Maybe' Int
maybeInt = Just' 115

myMaybeB  :: Maybe' Bool -> String
myMaybeB Nothing' = "Semmi"
myMaybeB (Just' False) = "H"
myMaybeB (Just' True) = "I"

f9 :: (Either a b -> c) -> (a -> c, b -> c)
--f9 f  = ( \a -> f (Left a), \b -> f (Right b))
--f9 f = (\a -> (f . Left) a , \b -> (f. Right) b )
f9 f = (f . Left , f . Right)

f10 :: (a -> c, b -> c) -> (Either a b -> c)
f10 (f,g) (Left a) = f a
f10 (f,g) (Right b) = g b

f11 :: Either (a, b) (a, c) -> (a, Either b c)
f11 (Left (a,b)) = (a,Left b)
f11 (Right (a,c)) = (a,Right c)

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
--applyMany [] a = []
--applyMany (f:fs) a = f a : applyMany fs a
--applyMany fs a = map (\f -> f $ a) fs
applyMany fs a = map ($ a) fs

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
--composeAll []   a = a
--composeAll (f:fs) a = f (composeAll fs a)
--composeAll fs (f:fs) a = foldr (\f acc -> f . acc) id fs
composeAll = foldr (.) id
-- call: composeAll [(+10),(*3)] 5
-- Definiáld a "merge :: Ord a => [a] -> [a] -> [a]" függvényt, ami két nemcsökkenő
-- rendezett listát összefésül úgy, hogy az eredmény is rendezett maradjon.
merge :: Ord a => [a] -> [a] -> [a]
merge [] [] = []
merge [] bs = bs
merge as [] = as
merge (a:as) (b:bs) | a <= b = ( a :  merge as (b:bs))
merge (a:as) (b:bs) | otherwise = ( b : merge (a:as) bs)


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
instance Eq Color where
  (==) = undefined

instance Ord Color where
  (<=) = undefined

instance Show Color where
  show = undefined

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