-- 0: alapok
type Dictionary = [(Char, Integer)]
dictionary :: [Char] -> Dictionary
dictionary x = zip x [1..]

dictionary_az = dictionary ['a'..'z']
dictionary_az_AZ = dictionary (['a'..'z']  ++ ['A'..'Z'])

-- 1: kereses oda vissza
charToNum :: Dictionary -> Char -> Integer

charToNum dict findChar 
 | null charLocation = 0
 | otherwise = head charLocation
 where charLocation = [ pos | (char,pos) <- dict , char==findChar ]

-- 2: kodhoz tartozo karakter
numToChar :: Dictionary -> Integer -> Char
numToChar dict findPos
 | null intAtChar = '*'
 | otherwise = head intAtChar
 where intAtChar = [ char | (char,pos) <- dict , pos==findPos ]

-- 3: szoveg lekepezese
translate :: Dictionary -> String -> [Integer]
translate dict str = map (charToNum dict) str

--
-- meg tobb kenyelmi fuggveny
isPrime :: Integer -> Bool
isPrime 0 = False
isPrime 1 = False
isPrime 2 = True
isPrime n = odd n && null [d | d <- [3,5..squareRoot n], n `mod` d == 0] where
  squareRoot :: Integer -> Integer
  squareRoot n = floor (sqrt (fromIntegral n))

primeList :: [Integer]
primeList = 2:[ x | x <- [3,5..], isPrime x]

-- 4: goedel szamma alakitas
encode :: Dictionary -> String -> Integer
encode dict str = foldl (*) 1 [ prime^intAtChar | (intAtChar,prime) <- zip (translate dict str) primeList ]

-- 5: primfaktorizacio

primeFactorAcc :: Integer -> [Integer] -> [Integer] -> [Integer]
primeFactorAcc prime acc (currPrime:primeList) 
 | prime == 1 = acc  
 | isDiv = primeFactorAcc (div prime currPrime) (currPrime:acc) (currPrime:primeList)
 | otherwise = primeFactorAcc prime acc primeList
 where isDiv = prime `mod` currPrime == 0

primeFactorization :: Integer -> [Integer]
primeFactorization number = reverse (primeFactorAcc number [] primeList)

-- 6: goedel szam dekodolasa


-- segito fuggveny
decodeReducer :: [Integer] -> Integer -> Integer -> [Integer] -> [Integer] 
-- *speciális eset, amikor 1-et (== üres string)-et akarunk dekódolni
decodeReducer [] 0 0 [] = []
-- *végeset*
decodeReducer [] _ occ acc = acc ++ [occ]
-- *első eset*
decodeReducer (currNum:rest) 0 0 [] = decodeReducer rest currNum 1 []
-- *rekurzív eset*
decodeReducer (currNum:rest) lastNum occ acc
 | currNum == lastNum = decodeReducer rest currNum (occ+1) acc
 | otherwise =  decodeReducer rest currNum 1 (acc ++ [occ])


decode :: Dictionary -> Integer -> String
decode dict number =  map (numToChar dict) (decodeReducer (primeFactorization number) 0 0 [])
