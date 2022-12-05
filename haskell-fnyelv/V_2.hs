{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE InstanceSigs #-}
{-# OPTIONS_GHC -Wincomplete-patterns -Wno-noncanonical-monad-instances #-}

import Control.Applicative
import Control.Monad
import Data.Char
import Data.Foldable
import Debug.Trace

-- State
--------------------------------------------------------------------------------

newtype State s a = State {runState :: s -> (a, s)}
  deriving (Functor)

instance Applicative (State s) where
  pure = return
  (<*>) = ap

instance Monad (State s) where
  return a = State (\s -> (a, s))
  (>>=) (State f) g = State $ \s -> case f s of
    (a, s) -> runState (g a) s

put :: s -> State s ()
put s = State $ \_ -> ((), s)

get :: State s s
get = State $ \s -> (s, s)

modify :: (s -> s) -> State s ()
modify f = do s <- get; put (f s)

evalState :: State s a -> s -> a
evalState sta s = fst (runState sta s)

execState :: State s a -> s -> s
execState sta s = snd (runState sta s)

-- FELADATOK
--------------------------------------------------------------------------------

data Tree a = Leaf a | Node1 (Tree a) | Node2 (Tree a) (Tree a)
  deriving (Show)

t1 :: Tree Int
t1 = Node1 (Node1 (Leaf 10))

t2 :: Tree Int
t2 = Node2 (Node1 (Leaf 10)) (Node1 (Leaf 20))

t3 :: Tree Int
t3 = Node2 (Node2 (Leaf 10) (Leaf 5)) (Node1 (Leaf 30))

instance Eq a => Eq (Tree a) where
  (==) (Leaf a) (Leaf b) = a == b
  (==) (Node1 a) (Node1 b) = a == b
  (==) (Node2 a a1) (Node2 b b1) = a == b && a1 == b1
  (==) _ _ = False

instance Functor Tree where
  fmap :: (a -> b) -> Tree a -> Tree b
  fmap f (Leaf a) = Leaf (f a)
  fmap f (Node1 a) = Node1 (fmap f a)
  fmap f (Node2 a b) = Node2 (fmap f a) (fmap f b)

instance Foldable Tree where
  foldr :: (a -> b -> b) -> b -> Tree a -> b
  foldr f b (Leaf a) = f a b
  foldr f b (Node1 a) = foldr f b a
  foldr f b (Node2 a a1) = foldr f (foldr f b a1) a

instance Traversable Tree where
  traverse f (Leaf a) = Leaf <$> f a
  traverse f (Node1 a) = Node1 <$> traverse f a
  traverse f (Node2 a a1) = Node2 <$> traverse f a <*> traverse f a1

countElems :: Tree a -> Int
countElems (Leaf a) = 1
countElems (Node1 a) = countElems a
countElems (Node2 a a1) = countElems a + countElems a1

countNode2 :: Tree a -> Int
countNode2 (Leaf a) = 0
countNode2 (Node1 a) = countNode2 a
countNode2 (Node2 a a1) = countNode2 a + countNode2 a1 + 1

labelFromRight :: Tree a -> Tree (Int, a)
labelFromRight t = evalState (traverse go t) ((countElems t) -1)
  where
    go x = do
      st <- get
      put (st - 1)
      return (st, x)

treeMaybe :: Tree (Maybe a) -> Maybe (Tree a)
treeMaybe t = traverse go t
  where
    go (Just a) = pure a
    go Nothing = Nothing

-- Parser lib
--------------------------------------------------------------------------------

newtype Parser a = Parser {runParser :: String -> Maybe (a, String)}
  deriving (Functor)

instance Applicative Parser where
  pure = return
  (<*>) = ap

instance Monad Parser where
  return :: a -> Parser a
  return a = Parser $ \s -> Just (a, s) -- nincs hatás

  (>>=) :: Parser a -> (a -> Parser b) -> Parser b
  Parser f >>= g = Parser $ \s -> do (a, s) <- f s; runParser (g a) s

-- pontosan az üres inputot olvassuk
eof :: Parser ()
eof = Parser $ \s -> case s of
  [] -> Just ((), [])
  _ -> Nothing

-- olvassunk egy karaktert az input elejéről, amire igaz egy feltétel
satisfy :: (Char -> Bool) -> Parser Char
satisfy f = Parser $ \s -> case s of
  c : s | f c -> Just (c, s)
  _ -> Nothing

-- olvassunk egy konkrét karaktert
char :: Char -> Parser ()
char c = () <$ satisfy (== c)

-- olvassunk egy konkrét String-et
string :: String -> Parser () -- String ~ [Char]
string s = mapM_ char s -- egymás után olvasom az összes Char-t a String-ben

instance Alternative Parser where
  -- mindig hibázó parser
  empty :: Parser a
  empty = Parser $ \_ -> Nothing

  -- választás két parser között
  Parser f <|> Parser g = Parser $ \s -> case f s of
    Nothing -> g s
    res -> res

-- Control.Applicative-ból:
--    many  :: Parser a -> Parser [a]       -- 0-szor vagy többször futtatja
--    some  :: Parser a -> Parser [a]       -- 1-szer vagy többször futtatja

many_ :: Parser a -> Parser ()
many_ pa = () <$ many pa

some_ :: Parser a -> Parser ()
some_ pa = () <$ some pa

-- Control.Applicative-ból:
-- optional :: Parser a -> Parser (Maybe a)   -- hibát értékként visszaadja (soha nem hibázik)
-- optional pa = (Just <$> pa) <|> pure Nothing

-- 0 vagy 1 eredményt olvasunk
optional_ :: Parser a -> Parser ()
optional_ pa = () <$ optional pa

-- olvassunk 1 vagy több pa-t, psep-el elválasztva
sepBy1 :: Parser a -> Parser sep -> Parser [a]
sepBy1 pa psep = do
  a <- pa
  as <- many (psep *> pa)
  pure (a : as)

-- olvassunk 0 vagy több pa-t, psep-el elválasztva
sepBy :: Parser a -> Parser sep -> Parser [a]
sepBy pa psep = sepBy1 pa psep <|> pure []

debug :: String -> Parser a -> Parser a
debug msg pa = Parser $ \s -> trace (msg ++ " : " ++ s) (runParser pa s)

-- token/ws parsing

ws :: Parser ()
ws = many_ (satisfy isSpace)

satisfy' :: (Char -> Bool) -> Parser Char
satisfy' f = satisfy f <* ws

char' :: Char -> Parser ()
char' c = char c <* ws

string' :: String -> Parser ()
string' s = string s <* ws

topLevel :: Parser a -> Parser a
topLevel pa = ws *> pa <* eof

-- operátor segédfüggvények

rightAssoc :: (a -> a -> a) -> Parser a -> Parser sep -> Parser a
rightAssoc f pa psep = foldr1 f <$> sepBy1 pa psep

leftAssoc :: (a -> a -> a) -> Parser a -> Parser sep -> Parser a
leftAssoc f pa psep = foldl1 f <$> sepBy1 pa psep

nonAssoc :: (a -> a -> a) -> Parser a -> Parser sep -> Parser a
nonAssoc f pa psep = do
  exps <- sepBy1 pa psep
  case exps of
    [e] -> pure e
    [e1, e2] -> pure (f e1 e2)
    _ -> empty

-- While nyelv
--------------------------------------------------------------------------------

data Exp
  = IntLit Int -- int literál (pozitív)
  | Add Exp Exp -- e + e
  | Sub Exp Exp -- e - e
  | Mul Exp Exp -- e * e
  | BoolLit Bool -- true|false
  | And Exp Exp -- e && e
  | Or Exp Exp -- e || e
  | Not Exp -- not e
  | Eq Exp Exp -- e == e
  | Var String -- (változónév)
  | ELeft Exp
  | ERight Exp
  deriving (Eq, Show)

{-
Változónév: nemüres alfabetikus string, ami nem kulcsszó

Kötési erősségek csökkenő sorrendben:
  - atom: zárójelezett kifejezés, literál, változónév
  - not alkalmazás
  - *  : jobbra asszoc
  - +  : jobbra asszoc
  - -  : jobbra asszoc
  - && : jobbra asszoc
  - || : jobbra asszoc
  - == : nem asszoc
-}

posInt' :: Parser Int
posInt' = do
  digits <- some (satisfy isDigit)
  ws
  pure (read digits)

keywords :: [String]
keywords = ["not", "true", "false", "while", "if", "do", "end", "then", "else", "Left", "Right", "case", "of", "->", ";"]

ident' :: Parser String
ident' = do
  x <- some (satisfy isAlpha) <* ws
  if elem x keywords
    then empty
    else pure x

keyword' :: String -> Parser ()
keyword' str = do
  x <- some (satisfy isAlpha) <* ws
  if x == str
    then pure ()
    else empty

atom :: Parser Exp
atom =
  (Var <$> ident')
    <|> (IntLit <$> posInt')
    <|> (BoolLit True <$ keyword' "true")
    <|> (BoolLit False <$ keyword' "false")
    <|> (char' '(' *> pExp <* char' ')')

pNot :: Parser Exp
pNot =
  (keyword' "not" *> (Not <$> atom))
    <|> (keyword' "Left" *> (ELeft <$> atom))
    <|> (keyword' "Right" *> (ERight <$> atom))
    <|> atom

mulExp :: Parser Exp
mulExp = rightAssoc Mul pNot (char' '*')

addExp :: Parser Exp
addExp = rightAssoc Add mulExp (char' '+')

subExp :: Parser Exp
subExp = rightAssoc Sub addExp (char' '-')

andExp :: Parser Exp
andExp = rightAssoc And subExp (string' "&&")

orExp :: Parser Exp
orExp = rightAssoc Or andExp (string' "||")

eqExp :: Parser Exp
eqExp = nonAssoc Eq orExp (string' "==")

pExp :: Parser Exp
pExp = eqExp

data Val = VInt Int | VBool Bool | VEither Val Val
  deriving (Eq, Show)

type Env = [(String, Val)]

evalExp :: Env -> Exp -> Val
evalExp env e = case e of
  IntLit n -> VInt n
  BoolLit b -> VBool b
  ELeft v -> case v of
    IntLit n -> VInt n
    BoolLit b -> VBool b
    _ -> error "type error ELeft"
  ERight v -> case v of
    IntLit n -> VInt n
    BoolLit b -> VBool b
    _ -> error "type error ERight"
  
  Add e1 e2 -> case (evalExp env e1, evalExp env e2) of
    (VInt n1, VInt n2) -> VInt (n1 + n2)
    _ -> error "type error"
  Sub e1 e2 -> case (evalExp env e1, evalExp env e2) of
    (VInt n1, VInt n2) -> VInt (n1 - n2)
    _ -> error "type error"
  Mul e1 e2 -> case (evalExp env e1, evalExp env e2) of
    (VInt n1, VInt n2) -> VInt (n1 * n2)
    _ -> error "type error"
  Or e1 e2 -> case (evalExp env e1, evalExp env e2) of
    (VBool b1, VBool b2) -> VBool (b1 || b2)
    _ -> error "type error"
  And e1 e2 -> case (evalExp env e1, evalExp env e2) of
    (VBool b1, VBool b2) -> VBool (b1 && b2)
    _ -> error "type error"
  Eq e1 e2 -> case (evalExp env e1, evalExp env e2) of
    (VBool b1, VBool b2) -> VBool (b1 == b2)
    (VInt n1, VInt n2) -> VBool (n1 == n2)
    _ -> error "type error"
  Not e -> case evalExp env e of
    VBool b -> VBool (not b)
    _ -> error "type error"
  Var x -> case lookup x env of
    Just v -> v
    Nothing -> error $ "name not in scope: " ++ x

--------------------------------------------------------------------------------

type Program = [Statement] -- st1; st2; st3; ... st4

data Statement
  = Assign String Exp -- x := e
  | While Exp Program -- while e do prog end
  | If Exp Program Program -- if e then prog1 else prog2 end
  | Case Exp String Program String Program
  deriving (Eq, Show)

statement :: Parser Statement
statement =
  ( Assign <$> ident'
      <*> (string' ":=" *> pExp)
  )
    <|> ( While <$> (keyword' "while" *> pExp <* keyword' "do")
            <*> (program <* keyword' "end")
        )
    <|> ( If <$> (keyword' "if" *> pExp <* keyword' "then")
            <*> (program <* keyword' "else")
            <*> (program <* keyword' "end")
        )
    <|> ( Case <$> (keyword' "case" *> pExp <* keyword' "of")
            <*> (keyword' "Left" *> ident' <* string' "->")
            <*> (program <* string' ";")
            <*> (keyword' "Right" *> ident' <* string' "->")
            <*> (program <* keyword' "end")
        )

program :: Parser Program
program = sepBy statement (char' ';')

updateEnv :: String -> Val -> Env -> Env
updateEnv x v [] = [(x, v)]
updateEnv x v ((x', v') : env)
  | x == x' = (x', v) : env
  | otherwise = (x', v') : updateEnv x v env

inNewScope :: State Env a -> State Env a
inNewScope ma = do
  env <- get
  let len = length env
  a <- ma
  env' <- get
  put $ take len env'
  pure a

evalStatement :: Statement -> State Env ()
evalStatement st = case st of
  -- ha x nincs env-ben, akkor vegyük fel az értékkel,
  -- egyébként pedig írjuk át az értékét
  Assign x e -> do
    env <- get
    let val = evalExp env e
    put $ updateEnv x val env

  -- while-on belüli új változók kívül nem látszanak
  While e p -> do
    env <- get
    case evalExp env e of
      VBool True -> inNewScope (evalProgram p) >> evalStatement (While e p)
      VBool False -> pure ()
      VInt _ -> error "type error"
      VEither _ _ -> error "type error VEither"

  -- if ágakban új változók kívül nem látszanak
  If e p1 p2 -> do
    env <- get
    case evalExp env e of
      VBool True -> inNewScope (evalProgram p1)
      VBool False -> inNewScope (evalProgram p2)
      VInt _ -> error "type error"
      VEither _ _ -> error "type error VEither"
  Case e x1 p1 x2 p2 -> do
    env <- get
    case evalExp env e of
      VBool _ -> error "type error"
      VInt _ -> error "type error"
      VEither _ _ -> error "See comment"
     --  VEither l r
     --   | e == l = inNewScope (assign x1 l >> evalProgram p1)
     --   | e == r = inNewScope (assign x2 r >> evalProgram p2)
        

evalProgram :: Program -> State Env ()
evalProgram = mapM_ evalStatement

run :: String -> Env
run str = case runParser (topLevel program) str of
  Just (prog, _) -> execState (evalProgram prog) []
  Nothing -> error "parse error"

p1 :: String
p1 = "i := 10; acc := 0; while not (i == 0) do acc := acc + i; i := i - 1 end"