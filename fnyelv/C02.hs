{-# options_ghc -Wincomplete-patterns #-}
module C02 where

-- Define a function that sums up all the numbers in a list of `Maybe Int`!

maybeSum :: [Maybe Int] -> Int
maybeSum [] = 0
maybeSum ((Nothing) : xs) = maybeSum xs
maybeSum ((Just x) : xs) = x + maybeSum xs


-- Example test cases:
-- ∙ maybeSum [Nothing] == 0
-- ∙ maybeSum [Just 15, Just 27] == 42
-- ∙ maybeSum [Just 3, Nothing, Just 8] == 11