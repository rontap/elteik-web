take' _ [] = []
take' n _
 | n <= 0 = []
take' n (a:xa) = a : take' (n-1) xa


drop' _ [] = []
drop' n _
 | n <= 0 = []
drop' 0 a = a 
drop' n (a:xa) = drop (n-1) xa

langAndRegion a = (take 2 a, drop 3 a)

zip' [] _ = []
zip' _ [] = []
zip' (a:ax) (b:bx) = (a,b) : zip' ax bx

unzip' [] = ([],[])
unzip' ((a,b):x )= (a : f, b : s)
 where (f,s) = unzip' x

{--
empty :: String -> Int
empty "" = 0
empty str = fromEnum((lineArr) == "") + empty (drop (length lineArr) str)
 where lineArr = head (lines str)
--}
 
 
empty str = snd (unzip (filter isEmpty (zip (lines str) [1..])))
 where isEmpty (a,_)  = a == ""
