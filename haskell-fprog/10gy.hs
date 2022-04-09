isLonger :: [a] -> Int -> Bool
isLonger [] comp
 | comp >= 0 = False
 | otherwise = True

isLonger (f:list) comp  
 | comp >= 0 = isLonger list (comp-1)
 | otherwise = True

runs :: Int -> [a] -> [[a]]
runs n [] = []
runs n list = [take n list] ++ runs n (drop n list)

join :: [listLike] -> [[listLike]] -> [listLike]
join el [] = []
join el (f:[]) = f
join el (f:list) = f ++ el ++ join el list
