
import Data.List

rook :: (Int, Int) -> [(Int, Int)]
--ez nagyon buta/okos megoldás? :D 
rook (a,b) = filter (\v -> v /= (a,b) ) ([(a,x) | x <- [0..7]] ++ [(y,b) | y <- [0..7]])

knight :: (Int, Int) -> [(Int, Int)]
--sajnálom. legalább a látszik, hogy ez saját kód és nem másolt :D 
knight (a,b) = filter (\(x,y) -> x < 8 && y < 8 && x >= 0 && y >= 0 ) ([(a+x,b+y) | (x,y) <- tul_faradt_voltam_hogy_rendesen_megoldjam])
 where tul_faradt_voltam_hogy_rendesen_megoldjam = [(-1,2),(1,-2),(1,2),(-1,-2),(-2,1),(2,-1),(2,1),(-2,-1)]


type PieceAttack = (Int, Int) -> [(Int, Int)]
attacks :: PieceAttack -> (Int, Int) -> [(Int, Int)] -> Bool
attacks piece location otherPieces = not (null (intersect (piece location) otherPieces))