nand :: Bool -> Bool -> Bool
nand True True = False
nand _ _ = True

onAxis :: (Int,Int) -> Bool
onAxis (_,0) = True
onAxis (0,_) = True
onAxis (_,_) = False

punctuation :: Char -> Bool
punctuation '?' = True
punctuation '!' = True
punctuation '.' = True
punctuation _ = False