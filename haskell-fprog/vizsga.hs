import Data.List


type Mat2 = ((Double, Double), (Double, Double))

--1.
transpose' :: Mat2 -> Mat2
transpose' ((a,b),(c,d)) = ((a,c),(b,d))

--2.
sameParity :: [Int] -> Bool
sameParity [] = True
sameParity (x:xs) = all (\c -> (c `mod` 2) == xmod) xs
 where xmod = (x `mod` 2)
 
--3.
clamp :: Ord a => a -> a -> a -> a
clamp low num high = sort [low, num, high]!!1 

--5.
countSingletons :: [[a]] -> Int

countSingletons a = csh a 0

csh [] c = c
csh (([]):ax) c = csh ax c
csh ((a:[]):ax) c = csh ax c+1
csh (a:ax) c = csh ax c
 
--6.
type Vec2 = (Double, Double)

vectorLength :: Vec2 -> Double
vectorLength (a,b) = sqrt ((a*a)+(b*b))

--7.
lengthOfPath :: [Vec2] -> Double
lengthOfPath [] = 0
lengthOfPath (a:[]) = 0
lengthOfPath ((x1,y1):(x2,y2):[]) = vectorLength ((x1-x2),(y1- y2)) 
lengthOfPath ((x1,y1):(x2,y2):xs) = vectorLength ((x1-x2),(y1- y2)) + lengthOfPath ((x2,y2):xs)

--8.
--travellingSalesman :: [Vec2] -> Double
--travellingSalesman xs =  xs


--9.
longestPrefix :: String -> String
longestPrefix x = longestPrefixHelper "" x
longestPrefixHelper a "" = a
longestPrefixHelper acc (x:curr)
 | length acc == length (x:curr)  = reverse acc ++  acc
 | isSuffixOf (x:acc) curr = longestPrefixHelper (x:acc) curr
 | otherwise = reverse acc

--10.
symmetricDiff :: Eq a => [a] -> [a] -> [a]
symmetricDiff a b = only a b ++ only b a
 where only c d = filter (\v -> not (elem v d)) c  

--11.
congruent :: Int -> Int -> Int -> Maybe Int
congruent a b m = congruent' a b m 0

congruent' a b m x
 | x > 100 = Nothing 
 | (a*x) `mod` m == b `mod` m = Just x
 | otherwise = congruent' a b m (x+1)


--12.

--closestTwo :: (Ord a, Num a) => a -> [a] -> (a, a)
closestTwo n a = map (\m -> ((abs (n - m),m))) a


--13.

{-
getResultCodes :: [LogEntry] -> [Int]
data LogEntry = Error String | Message String | ResultCode Int deriving (Show, Eq)

getResultCodes x = getResultCodesReducer x []
--getResultCodesReducer :: [LogEntry] -> [Int] -> [Int]
getResultCodesReducer ((ResultCode x):xs) c = getResultCodesReducer xs c
getResultCodesReducer ((Error x):xs) c = getResultCodesReducer xs c
getResultCodesReducer ((Message x):xs) c = getResultCodesReducer xs c
-}
testLog = [
  Message "Spawning worker thread.",
  Message "Worker thread finished.",
  ResultCode 0,
  Message "Opening input file.", 
  Message "Reading 32 bytes.", 
  Error "Not enough bytes",
  Message "Connecting to 127.0.0.1.",
  Message "Sending packets.",
  Message "Packets sent.",
  ResultCode 100,
  Message "Compiling shaders.",
  Message "Linking.",
  Message "Allocating VAO and VBO",
  Message "Drawing cube",
  ResultCode 23,
  Message "Connecting to 213.32.12.2",
  Error "Connection failed"
  ]


