type Sign = Int
type Play = [Sign]
type Rounds = (Play, Play)

validSigns :: (Sign -> Sign -> a) -> Sign -> Sign -> a 
validSigns f a b
 | (elem a ints && elem b ints) = f a b
 | otherwise = error "invalid values" 
 where ints = [0,1,2]

beats :: Sign -> Sign -> Bool
beats a b = validSigns beatsHelper a b 
beatsHelper a b 
 | a == 0 && b == 2 = True
 | a == 2 && b == 1 = True
 | a == 1 && b == 0 = True
 | otherwise =  False
 
isDraw :: Sign -> Sign -> Bool
isDraw a b = validSigns (\a b -> a == b) a b 

result :: Sign -> Sign -> Int
result a b = validSigns resultHelper a b
resultHelper a b
 | isDraw a b = 0
 | beats a b = 1
 | otherwise = -1



tournament :: Rounds -> Int
tournament r
 | result < 0 = 2
 | result > 0 = 1
 | otherwise = 0
 where result = tournamentReducer r
tournamentReducer ([],[]) = 0
tournamentReducer (a:ax,b:bx) =  (result a b) + (tournamentReducer (ax,bx))

