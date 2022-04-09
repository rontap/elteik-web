module C01 where

-- Define a function that fits the following type annotation!

f8 :: (a -> b, a -> c) -> (a -> (b, c))
f8 (f,g) = \a -> (f a, g a)

-- ezzel obviously eqivalens ugye

f8' (f,g) a = (f a, g a)