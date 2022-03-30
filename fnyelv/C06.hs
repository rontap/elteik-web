{-# options_ghc -Wincomplete-patterns #-}
module C06 where

-- The tasks begin on line 65.

import Control.Monad

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


{- Stack -}

type Stack a b = State [a] b

runStack :: Stack a b -> (b, [a])
runStack s = runState s []

evalStack :: Stack a b -> b
evalStack s = evalState s []

execStack :: Stack a b -> [a]
execStack s = execState s []

isEmpty :: State [a] Bool
isEmpty = null <$> get

push :: a -> Stack a ()
push a = modify (a:)

pop :: Stack a a
pop = do{st<-get; case st of (a:as)->put as>>pure a; []->error "nothing to pop"}

top :: Stack a a
top = head <$> get


{- Tasks -}

-- Task 1: Extend the stack interface with a `depth` function, which determines
--         how many items are contained in the stack.

depth :: Stack a Int
depth = do
  a <- isEmpty
  if a then return 0 else do
    _ <- pop
    return (1) : depth <$> get

{-
  Examples:
  ∙ evalStack (do {depth}) == 0
  ∙ evalStack (do {push False; depth}) == 1
  ∙ evalStack (do {push 'a'; push 'b'; push 'c'; depth}) == 3
  ∙ evalStack (do {push 'a'; push 'b'; pop; push 'c'; depth}) == 2
-}

-- Task 2: Write a function that checks if there are at least two numbers
--         in the stack and if this condition is satisfied, replaces the top
--         two values with their sum.
--
--         Constraint: Pattern matching is not allowed,
--                     use monadic operations instead!

tryAdd :: Stack Int ()
tryAdd = undefined

{-
  Examples:
  ∙ execStack (do {tryAdd}) == []
  ∙ execStack (do {push 5; tryAdd}) == [5]
  ∙ execStack (do {push 5; push 8; tryAdd}) == [13]
  ∙ execStack (do {push 5; push 8; push 2; tryAdd}) == [10, 5]
  ∙ execStack (do {push 5; pop; push 8; tryAdd}) == [8]
-}
