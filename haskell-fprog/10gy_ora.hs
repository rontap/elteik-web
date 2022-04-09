import Data.Char

filter' f [] = []
filter' f (l:lx) 
 | f (l) == True = l : filter' f lx
 | otherwise = filter' f lx

upperToLower [] = []
upperToLower (l:lx)
 | isUpper l = (toLower l) : upperToLower lx
 | otherwise = upperToLower lx

all' f [] = True
all' f (l:lx) 
 | f l = all' f lx
 | otherwise = False

any' f [] = False
any' f (l:lx) 
 | f l = True
 | otherwise = any' f lx

hasLongLines t = any (\n -> n >= 3) ( map length (map words (lines t)))

{-
elem' e [] = False
elem' e (x:xs)
 | e == x = True
 | otherwise = elem' e xs
-}

elem' f l = any (\e -> e == f) l

hasAny ll la = any (\e -> elem' e la) ll

takeWhile' pred (l:lx)
 | pred l = l : takeWhile' pred lx
 | otherwise =  []

dropWhile' _ [] = []
dropWhile' pred llx@(l:lx)
 | pred l = dropWhile' pred lx
 | otherwise = llx


dropWord w = concat ( tail (words w))

users :: [(String, String)]
users = [ ("mrbean", "4321"), ("admin", "s3cr3t"), ("finn", "algebraic")]

type PieceAttack = (Int, Int) -> [(Int, Int)]
attacks :: PieceAttack -> (Int, Int) -> [(Int, Int)] -> Bool

doesUserExist user inObj = any (\n -> fst n == user) inObj
