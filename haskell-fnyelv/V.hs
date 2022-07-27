{-# LANGUAGE DeriveFunctor #-}
{-# OPTIONS_GHC -Wincomplete-patterns #-}
import Control.Applicative
import Control.Monad
import Data.Char
import Data.Maybe

data Tree a = Leaf a
            | Node (Maybe (Tree a)) (Maybe (Tree a))
  deriving (Show)

t1 :: Tree Int
t1 = Node (Just (Node (Just (Leaf 1)) (Just (Leaf 2)))) (Just (Leaf 3))

t2 :: Tree Int
t2 = Node Nothing (Just (Node Nothing Nothing))

t3 :: Tree Int
t3 = Node (Just (Node (Just (Leaf 10)) (Just (Leaf 5)))) (Just (Node Nothing Nothing))


-- F1 <---
instance (Eq a) => Eq (Tree a) where
  Leaf a == Leaf b = a == b
  Node Nothing Nothing == Node Nothing Nothing = True
  Node a b == Node a' b' = a == a' && b == b'
  _ == _ = False


instance Functor Tree where
  fmap f (Leaf a)  = Leaf (f a)
  fmap f (Node Nothing Nothing) = Node Nothing Nothing
  fmap f (Node (Just a) (Just b)) = Node (Just (fmap f a)) (Just (fmap f b))
  fmap f (Node Nothing (Just b)) = Node (Nothing) (Just (fmap f b))
  fmap f (Node (Just b) Nothing) = Node  (Just (fmap f b)) (Nothing)



instance Foldable Tree where
  foldr f acc (Leaf a) = f a acc
  foldr f acc (Node (Just l) (Just r)) =
    let
      r' = foldr f acc r
      l' = foldr f r' l
    in
      l'
  foldr f acc (Node Nothing (Just r)) = foldr f acc r
  foldr f acc (Node (Just r) Nothing ) = foldr f acc r
  foldr f acc (Node Nothing Nothing ) = acc


instance Traversable Tree where
  traverse f (Leaf a)   = Leaf <$> (f a)
 -- traverse f (Node (Just l) (Just r)) = Node <$>  (traverse f l) <*> (traverse f r)
 {- traverse f (Node Nothing (Just r)) = Node <$> Nothing <$> (traverse f r)
  traverse f (Node (Just l) Nothing) = Node <$> (traverse f l) <$> Nothing
  traverse f (Node Nothing Nothing) = Node Nothing Nothing
-}


countElems :: Tree a -> Int
countElems (Leaf a) = 1
countElems (Node (Just l) Nothing) = countElems l
countElems (Node Nothing (Just r)) = countElems r
countElems (Node Nothing Nothing) = 0
countElems (Node (Just l) (Just r)) = countElems l + countElems r


countJusts :: Tree a -> Int
countJusts (Leaf a) = 0
countJusts (Node (Just l) Nothing) = countJusts l + 1
countJusts (Node Nothing (Just r)) = countJusts r + 1
countJusts (Node Nothing Nothing) = 0
countJusts (Node (Just l) (Just r)) = countJusts l + countJusts r + 2


replaceNothings :: Maybe (Tree a) -> Tree a -> Tree a
replaceNothings mta (Node (Just l) Nothing)  =  Node (Just (replaceNothings mta l)) mta
replaceNothings mta (Node Nothing (Just r))  =  Node  mta  (Just (replaceNothings mta r))
replaceNothings mta (Node Nothing Nothing)  =   Node  mta  mta
replaceNothings mta (Node (Just l) (Just r))  =  Node  (Just (replaceNothings mta l))  (Just (replaceNothings mta r))
replaceNothings mta a = a


-- ez nem megy mert traverse nem megy
{-
shiftElems :: a -> Maybe a -> Maybe a
shiftElems d t = evalState (traverse go t) d where
  go :: a -> State a a
  go a = do
    prev <- get
    put a
    return prev
-}

---



simplifyTree :: Tree a -> Maybe (Tree a)
simplifyTree  (Node Nothing Nothing) = Nothing
simplifyTree  a = Just a



------------------------------------- WHILE ------

--------------------------------------------------------------------------------
--                  While nyelv parser + interpreter
--------------------------------------------------------------------------------

newtype Parser a = Parser {runParser :: String -> Maybe (a, String)}
  deriving Functor

instance Applicative Parser where
  pure = return
  (<*>) = ap

instance Monad Parser where
  return a = Parser $ \s -> Just (a, s)
  Parser f >>= g = Parser $ \s ->
    case f s of
      Nothing     -> Nothing
      Just(a, s') -> runParser (g a) s'

instance Alternative Parser where
  empty = Parser $ \_ -> Nothing
  (<|>) (Parser f) (Parser g) = Parser $ \s -> case f s of
    Nothing -> g s
    x       -> x

satisfy :: (Char -> Bool) -> Parser Char
satisfy f = Parser $ \s -> case s of
  c:cs | f c -> Just (c, cs)
  _          -> Nothing

eof :: Parser ()
eof = Parser $ \s -> case s of
  [] -> Just ((), [])
  _  -> Nothing

char :: Char -> Parser ()
char c = () <$ satisfy (==c)

string :: String -> Parser ()
string = mapM_ char

ws :: Parser ()
ws = () <$ many (char ' ' <|> char '\n')

sepBy1 :: Parser a -> Parser b -> Parser [a]
sepBy1 pa pb = (:) <$> pa <*> many (pb *> pa)

sepBy :: Parser a -> Parser b -> Parser [a]
sepBy pa pb = sepBy1 pa pb <|> pure []

anyChar :: Parser Char
anyChar = satisfy (const True)

-- While nyelv
------------------------------------------------------------

data Exp
  = Add Exp Exp    -- a + b
  | Mul Exp Exp    -- a * b
  | Var Name       -- x
  | IntLit Int
  | BoolLit Bool   -- true|false
  | Not Exp        -- not e
  | And Exp Exp    -- a && b
  | Or Exp Exp     -- a || b
  | Eq Exp Exp     -- a == b
  | Lt Exp Exp     -- a < b
  | ENothing Exp
  | EJust Exp
  deriving (Eq, Show)

type Program = [Statement]
type Name    = String

data Statement
  = Assign Name Exp         -- x := e
  | While Exp Program       -- while e do p1 end
  | For Name Exp Exp Program -- for var from e1 to e2 do p1 end
  | If Exp Program Program  -- if e then p1 else p2 end
  | Block Program           -- {p1}  (lokális scope)
  | Case Exp Program String Program Statement
  deriving (Eq, Show)


-- While parser
--------------------------------------------------------------------------------

{-
Parser a While nyelvhez. A szintaxist az Exp és Statement definíciónál látahtó
fenti kommentek összegzik, továbbá:

  - mindenhol lehet whitespace tokenek között
  - a Statement-eket egy Program-ban válassza el ';'
  - Az operátorok erőssége és assszociativitása a következő (csökkenő erősségi sorrendben):
      *  (bal asszoc)
      +  (bal asszoc)
      <  (nem asszoc)
      == (nem asszoc)
      && (jobb asszoc)
      || (jobb asszoc)
  - "not" erősebben köt minden operátornál.
  - A kulcsszavak: not, and, while, do, if, end, true, false.
  - A változónevek legyenek betűk olyan nemüres sorozatai, amelyek *nem* kulcsszavak.
    Pl. "while" nem azonosító, viszont "whilefoo" már az!

Példa szintaktikilag helyes programra:

  x := 10;
  y := x * x + 10;
  while (x == 0) do
    x := x + 1;
    b := true && false || not true
  end;
  z := x
-}

char' :: Char -> Parser ()
char' c = char c <* ws

string' :: String -> Parser ()
string' s = string s <* ws

keywords :: [String]
keywords = ["not", "while", "Nothing","Just","for", "do", "from", "to", "if", "then", "else", "end", "true", "false"]

pIdent :: Parser String
pIdent = do
  x <- some (satisfy isLetter) <* ws
  if elem x keywords
    then empty
    else pure x

pKeyword :: String -> Parser ()
pKeyword str = do
  string str
  mc <- optional (satisfy isLetter)
  case mc of
    Nothing -> ws
    Just _  -> empty

pBoolLit :: Parser Bool
pBoolLit = (True  <$ pKeyword "true")
       <|> (False <$ pKeyword "false")

pIntLit :: Parser Int
pIntLit = read <$> (some (satisfy isDigit) <* ws)

pAtom :: Parser Exp
pAtom = (BoolLit <$> pBoolLit)
      <|> (IntLit <$> pIntLit)
      <|> (Var <$> pIdent)
      <|> (char' '(' *> pExp <* char' ')')

pNot :: Parser Exp
pNot =
      (Not <$> (pKeyword "not" *> pAtom))
  <|> (EJust <$> (pKeyword "Just" *> pAtom))
  <|> pAtom

pMul :: Parser Exp
pMul = foldl1 Mul <$> sepBy1 pNot (char' '*')

pAdd :: Parser Exp
pAdd = foldl1 Add <$> sepBy1 pMul (char' '+')

pLt :: Parser Exp
pLt = do
  e <- pAdd
  (Lt e <$> (string' "<"  *> pAdd)) <|> pure e

pEq :: Parser Exp
pEq = do
  e <- pLt
  (Lt e <$> (string' "==" *> pLt)) <|> pure e

pAnd :: Parser Exp
pAnd = foldr1 And <$> sepBy1 pEq (string' "&&")

pOr :: Parser Exp
pOr = foldr1 Or <$> sepBy1 pAnd (string' "||")

pExp :: Parser Exp
pExp = pOr

pProgram :: Parser Program
pProgram = sepBy pStatement (char' ';')

pStatement :: Parser Statement
pStatement =
        (Assign <$> pIdent <*> (string' ":=" *> pExp))
    <|> (While <$> (pKeyword "while" *> pExp)
               <*> (pKeyword "do" *> pProgram <* pKeyword "end"))
    <|> (For <$> (pKeyword "for" *> pIdent) <*> (pKeyword "from" *> pExp) <*> (pKeyword "to" *> pExp) <*> (pKeyword "do" *> pProgram <* pKeyword "end"))
    <|> (If <$> (pKeyword "if"   *> pExp)
            <*> (pKeyword "then" *> pProgram)
            <*> (pKeyword "else" *> pProgram <* pKeyword "end"))
    <|> (Block <$> (char' '{' *> pProgram <* char' '}'))
    --case x of Nothing -> x := Just 10; Just foo -> x := Just (foo + 1) end
    {-
    <|> (Case
      <$> (pKeyword "case" *> pExp)
      <*> (pKeyword "of" *> pProgram)
      <*> (string "->" *> pProgram)
      <*> (char' ";" *> pProgram)
      <*> ( pProgram <* pKeyword  "end")
    )
    -}

pSrc :: Parser Program
pSrc = ws *> pProgram <* eof

------------------------------------------------------------

--------------------------------------------------------------------------------
-- State monad
--------------------------------------------------------------------------------

newtype State s a = State {runState :: s -> (a, s)}
  deriving Functor

instance Applicative (State s) where
  pure  = return
  (<*>) = ap

instance Monad (State s) where
  return a = State $ \s -> (a, s)
  State f >>= g = State $ \s -> case f s of
    (a, s') -> runState (g a) s'

get :: State s s
get = State $ \s -> (s, s)

put :: s -> State s ()
put s = State $ \_ -> ((), s)

modify :: (s -> s) -> State s ()
modify f = get >>= \s -> put (f s)

evalState :: State s a -> s -> a
evalState ma = fst . runState ma

execState :: State s a -> s -> s
execState ma = snd . runState ma


-----------
type Val  = Either Int Bool
type Env  = [(Name, Val)]
type Eval = State Env

evalExp :: Exp -> Eval Val
evalExp e = case e of

  Add e1 e2 -> do
    v1 <- evalExp e1
    v2 <- evalExp e2
    case (v1, v2) of
      (Left n1, Left n2) -> pure (Left (n1 + n2))
      _                  -> error "type error in + argument"
  Mul e1 e2 -> do
    v1 <- evalExp e1
    v2 <- evalExp e2
    case (v1, v2) of
      (Left n1, Left n2) -> pure (Left (n1 * n2))
      _                  -> error "type error in * argument"
  Or e1 e2 -> do
    v1 <- evalExp e1
    v2 <- evalExp e2
    case (v1, v2) of
      (Right b1, Right b2) -> pure (Right (b1 || b2))
      _                    -> error "type error in || argument"
  And e1 e2 -> do
    v1 <- evalExp e1
    v2 <- evalExp e2
    case (v1, v2) of
      (Right b1, Right b2) -> pure (Right (b1 && b2))
      _                    -> error "type error in && argument"
  Eq  e1 e2 -> do
    v1 <- evalExp e1
    v2 <- evalExp e2
    case (v1, v2) of
      (Left  n1, Left  n2) -> pure (Right (n1 == n2))
      (Right b1, Right b2) -> pure (Right (b1 == b2))
      _                    -> error "type error in == arguments"
  Lt  e1 e2 -> do
    v1 <- evalExp e1
    v2 <- evalExp e2
    case (v1, v2) of
      (Left  n1, Left  n2) -> pure (Right (n1 < n2))
      _                    -> error "type error in < arguments"
  Var x -> do
    env <- get
    case lookup x env of
      Nothing -> error ("variable not in scope: " ++ x)
      Just v  -> pure v
  IntLit n ->
    pure (Left n)
  BoolLit b ->
    pure (Right b)


  ENothing exp -> do
    v <- evalExp exp
    case v of
          Right b -> pure (Right False)
          _       -> error "type error in \"not\" argument"

  EJust exp -> do
    v <- evalExp exp
    case v of
          Right b -> pure (Right (b))
          _       -> error "type error in \"not\" argument"


  Not e -> do
    v <- evalExp e
    case v of
      Right b -> pure (Right (not b))
      _       -> error "type error in \"not\" argument"

newScope :: Eval a -> Eval a
newScope ma = do
  env <- (get :: State Env Env)
  a <- ma
  modify (\env' -> drop (length env' - length env) env')
  pure a

updateEnv :: Name -> Val -> Env -> Env
updateEnv x v env =
  case go env of
    Nothing   -> (x, v):env
    Just env' -> env'
  where
    go :: Env -> Maybe Env
    go [] = Nothing
    go ((x', v'):env)
      | x == x'   = Just ((x, v):env)
      | otherwise = ((x', v'):) <$> go env

evalSt :: Statement -> Eval ()
evalSt s = case s of
  Assign x e -> do
    v <- evalExp e
    modify (updateEnv x v)
  While e p -> do
    v <- evalExp e
    case v of
      Right b -> if b then newScope (evalProg p) >> evalSt (While e p)
                      else pure ()
      Left _  -> error "type error: expected a Bool condition in \"while\" expression"
  For x e1 e2 p -> do
      v1 <- evalExp e1
      v2 <- evalExp e2
      case (v1,v2) of
          (Left v1', Left v2') | v1' < v2' -> {-kell még: x-nek v1'-et értékül adni-} {-x új scope-ban létezzen csak-} newScope (evalProg p) {-kell még: x := x + 1; -}
          {-kell még: v1' >= v2', ekkor a végére értünk és többet nem kell futtatni. -}
          _ -> error "type error in statement \"for\""
  If e p1 p2 -> do
    v <- evalExp e
    case v of
      Right b -> if b then newScope (evalProg p1)
                      else newScope (evalProg p2)
      Left _ -> error "type error: expected a Bool condition in \"if\" expression"
  Block p ->
    newScope (evalProg p)

evalProg :: Program -> Eval ()
evalProg = mapM_ evalSt


-- interpreter
--------------------------------------------------------------------------------

runProg :: String -> Env
runProg str = case runParser pSrc str of
  Nothing     -> error "parse error"
  Just (p, _) -> execState (evalProg p) []

p1 :: String
p1 = "x := 10; y := 20; {z := x + y}; x := x + 100"