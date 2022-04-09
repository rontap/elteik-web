

sum' (x:[]) = x
sum' (x:xs) = x + sum xs

last' (x:[]) = x
last' (x:xs) = last xs

and' [] = True
and' (x:[]) =  x 
and' (x:xs) = x && and' xs


or' [] = False
or' (x:[]) =  x 
or' (x:xs) = x || or' xs

repeat' s = [s] ++ repeat' s

replicate' x w = take x (repeat' w)

format x text 
 | x <= length text = text
 | otherwise = ' ' : format (x-1) text


insert n [] = [n]

insert n (l:[]) 
 | n < l = n:l:[]
 | otherwise = l:n:[]

insert n (l:lx) 
 | n < l = n : l : lx
 | otherwise = l : insert n lx


sort [] = []
sort (x:[]) = [x]
sort (x:xs) = insert x (sort xs)

merge a [] = a
merge [] b = b
merge al@(a:ax) bl@(b:bx)
 | a < b = a : (merge ax bl)
 | a >= b = b : (merge al bx)


mergeSort [] = []
mergeSort (a:[]) = [a]
mergeSort list = merge (mergeSort a)  (mergeSort b)
 where (a,b) = splitAt (length list `div` 2) list
