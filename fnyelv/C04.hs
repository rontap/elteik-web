{-# options_ghc -Wincomplete-patterns #-}
module C04 where

-- Define composition for functions that do not always produce a value,
-- can sometimes fail and return nothing.
-- In case of a failure, it should be propagated to the final result.

composeMaybe :: (b -> Maybe c) -> (a -> Maybe b) -> (a -> Maybe c)
{- composeMaybe a b v = do
  av <- b v
  cv <- a av
  return cv
-}

composeMaybe f g a = g a >== f -- a 'c<- <-> return' kb egymás ellentettje. Do notáció egy operátorral nem szűkséges

-- Examples:
-- ∙ composeMaybe (Just . (*5)) (Just . (+3)) 5 == Just 40
-- ∙ composeMaybe (Just . (+2)) (Just . (*4)) 6 == Just 26
-- ∙ composeMaybe (Just . (+2)) (const Nothing) 7 == Nothing
-- ∙ composeMaybe (\b -> if b then Just "ok" else Nothing) (Just . not) True == Nothing
-- ∙ composeMaybe (\b -> if b then Just "ok" else Nothing) (Just . not) False == Just "ok"