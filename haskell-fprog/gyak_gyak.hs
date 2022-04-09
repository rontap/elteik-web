type Binary = [Bit]

plus1 (One:[]) = Zero : [One]
plus1 (One:xs) = Zero : (plus1 xs)
plus1 (Zero:xs) = One : xs
