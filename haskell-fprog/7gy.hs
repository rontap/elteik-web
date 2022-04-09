import Data.Char

isIdentifierStart:: Char -> Bool
isIdentifierStart '_' = True
isIdentifierStart c = isLower c

isIdentifierPart:: Char -> Bool
isIdentifierPart c = isDigit c || isLetter c || c == '_' 

isReserved::[Char] -> Bool
isReserved str = elem str ["if","then","else","module","import"]


pow x 1 = x
pow x y = x * (pow x (y-1)) 
 
 
range f t
 | f == t = [t]
 | f < t = f :range (f+1) t
 


min' (x:l:[]) 
 | x > l = l
 | x < l = x
 
min' (x:l:xs) 
 | x > l = x :min' x xs
 | x < l = l :min' l xs
 


isValid::[Char] -> Bool
isValid "" = False 
-- nem tudom hogy a listaértelmezés az itt lusta-e, mert ha nem, akkor nem ideális ez az algoritmus
isValid str = not(isReserved str) && isIdentifierStart (head str) && not(elem False [isIdentifierPart a | a <- tail str])




