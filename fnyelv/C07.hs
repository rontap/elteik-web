{-# language InstanceSigs, DeriveFunctor, DeriveFoldable, DeriveTraversable #-}
{-# options_ghc -Wincomplete-patterns #-}
module C07 where

-- The tasks begin on line 45.

import Control.Monad
import Data.Foldable

{- State -}

newtype State s a = State {runState :: s -> (a, s)}

instance Functor (State s) where
  fmap = liftM

instance Applicative (State s) where
  pure  = return
  (<*>) = ap

instance Monad (State s) where
  return a = State (\s -> (a, s))
  (State f) >>= g = State (\s -> case (f s) of (a, s') -> runState (g a) s')

get :: State s s
get = State (\s -> (s, s))

put :: s -> State s ()
put s = State (\_ -> ((), s))

modify :: (s -> s) -> State s ()
modify f = do {s <- get; put (f s)}

evalState :: State s a -> s -> a
evalState ma = fst . runState ma

execState :: State s a -> s -> s
execState ma = snd . runState ma

{- Tree -}

data Tree a = Leaf a | Node (Tree a) (Tree a)
  deriving (Show, Eq, Functor, Foldable, Traversable)

{- Tasks -}

-- Task #1: Write a function that compares numbers stored in a tree and replaces
--          the values by their relation to their preceding neighbor.
--          ∙ `Same`, if they are equal
--          ∙ `More`, if it is greater than the previous one
--          ∙ `Less`, if it is smaller than the previous one
--          Since the first element has no preceding neighbor, you should
--          compare it to 0.

data Relation = Less | Same | More deriving (Show, Eq)

relative :: Tree Int -> Tree Relation
relative as = evalState (traverse go as) 0 where
  go :: Int -> State Int Relation
  go a = do
    m <- get
    put a
    if m == a then return Same else do
      if m > a then return Less else do
        return More

{-
  Examples:
  ∙ relative (Leaf 5   )
          == (Leaf More)
  ∙ relative (Node (Node (Leaf 0   ) (Leaf 5   )) (Leaf 3   ))  == (Node (Node (Leaf Same) (Leaf More)) (Leaf Less))
  ∙ relative (Node (Leaf (-2)) (Node (Node (Leaf (-6)) (Leaf (-6))) (Leaf (-4))))  == (Node (Leaf Less) (Node (Node (Leaf Less) (Leaf Same)) (Leaf More)))
-}


-- Task #2: Write a function that shifts values one step to the right in a tree!
--          The shift should be circular, meaning that the last value should
--          wrap around and go into the first position. You can get the last
--          value in a tree `t` using the foldable instance: `last $ toList t`.
lit t = last $ toList t

shift :: Tree a -> Tree a
shift as = evalState (traverse go as) (last $ toList as) where
  go :: a -> State a a
  go a = do
    m <- get
    put a
    return m

{-
  Examples:
  ∙ shift (Leaf True)
       == (Leaf True)
  ∙ shift (Node (Node (Leaf 0) (Leaf 5)) (Leaf 3))  == (Node (Node (Leaf 3) (Leaf 0)) (Leaf 5))
  ∙ shift (Node (Leaf 'a') (Node (Node (Leaf 'b') (Leaf 'c')) (Leaf 'd')))       == (Node (Leaf 'd') (Node (Node (Leaf 'a') (Leaf 'b')) (Leaf 'c')))
-}
