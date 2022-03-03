{-# language InstanceSigs #-}
module C03 where

data SparseList a
  = Cons a (SparseList a)
  | Skip (SparseList a)
  | Nil
  deriving (Show, Eq)

-- Write a functor instance for the sparse list (a list that doesn't necessarily
-- have elements at all indices) type given by the definition above.

instance Functor SparseList where
  fmap :: (a -> b) -> SparseList a -> SparseList b
  fmap f Nil = Nil
  fmap f (Cons a st) = Cons (f a) (fmap f st)
  fmap f (Skip st) = Skip (fmap f st)

{-
   Some example evaluations:
   - fmap (+3) Nil                                         == Nil
   - fmap id (Cons () (Skip (Skip Nil)))                   == (Cons () (Skip (Skip Nil)))
   - fmap not (Cons True (Skip (Cons False Nil)))          == (Cons False (Skip (Cons True Nil)))
   - fmap (*2) (Cons 1 (Cons 4 (Skip Nil)))                == (Cons 2 (Cons 8 (Skip Nil)))
   - fmap reverse (Skip (Cons "asdf" (Cons "qwerty" Nil))) == (Skip (Cons "fdsa" (Cons "ytrewq" Nil)))
-}
