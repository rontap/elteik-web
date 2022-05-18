{-# language InstanceSigs, DeriveFunctor #-}
{-# options_ghc -Wincomplete-patterns #-}
module C11 where

import Control.Monad
import Control.Applicative
import Data.Char
import Data.Maybe
import Debug.Trace

-- PARSER LIBRARY
--------------------------------------------------------------------------------

newtype Parser a = Parser {runParser :: String -> Maybe (a, String)}
  deriving (Functor)

evalParser :: Parser a -> String -> Maybe a
evalParser pa = (fst <$>) . runParser pa

execParser :: Parser a -> String -> Maybe String
execParser pa = (snd <$>) . runParser pa

instance Applicative Parser where
  pure  = return
  (<*>) = ap

instance Monad Parser where
  return :: a -> Parser a
  return a = Parser $ \s -> Just (a, s)

  (>>=) :: Parser a -> (a -> Parser b) -> Parser b
  Parser f >>= g = Parser $ \s -> do {(a, s) <- f s; runParser (g a) s}

eof :: Parser ()
eof = Parser $ \s -> case s of
  [] -> Just ((), [])
  _  -> Nothing

satisfy :: (Char -> Bool) -> Parser Char
satisfy f = Parser $ \s -> case s of
  c:s | f c -> Just (c, s)
  _         -> Nothing

char :: Char -> Parser ()
char c = () <$ satisfy (==c)

string :: String -> Parser ()
string s = mapM_ char s

instance Alternative Parser where
  -- mindig hibázó parser
  empty :: Parser a
  empty = Parser $ \_ -> Nothing

  -- választás két parser között
  Parser f <|> Parser g = Parser $ \s -> case f s of
    Nothing -> g s
    res     -> res

-- Control.Applicative-ból:
-- ∙ many  :: Parser a -> Parser [a]
-- ∙ some  :: Parser a -> Parser [a]

many_ :: Parser a -> Parser ()
many_ pa = () <$ many pa

some_ :: Parser a -> Parser ()
some_ pa = () <$ some pa

-- Control.Applicative-ból:
-- ∙ optional :: Parser a -> Parser (Maybe a)

optional_ :: Parser a -> Parser ()
optional_ pa = () <$ optional pa

inList :: [Char] -> Parser Char
inList str = satisfy (`elem` str)

inList_ :: [Char] -> Parser ()
inList_ str = () <$ inList str

------------------------------------------------------------

-- olvassunk 1 vagy több pa-t, psep-el elválasztva
--   pa psep pa .... psep pa
sepBy1 :: Parser a -> Parser sep -> Parser [a]
sepBy1 pa psep = do
  a  <- pa
  as <- many (psep *> pa)
  pure (a:as)

-- olvassunk 0 vagy több pa-t, psep-el elválasztva
sepBy :: Parser a -> Parser sep -> Parser [a]
sepBy pa psep = sepBy1 pa psep <|> pure []

debug :: String -> Parser a -> Parser a
debug msg pa = Parser $ \s -> trace (msg ++ " : " ++ s) (runParser pa s)

-- token/whitespace parsing segédfüggvények

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
    [e]      -> pure e
    [e1,e2]  -> pure (f e1 e2)
    _        -> empty

-- number parsing

digit :: Parser Int
digit = digitToInt <$> satisfy isDigit

decimalNumber :: Parser Int
decimalNumber = foldl (\a c -> a * 10 + c) 0 <$> some digit


-- Expressions

data Exp
  = Lit Int
  | Plus Exp Exp
  | Mult Exp Exp
  | Lt Exp Exp
  | Eq Exp Exp
  deriving Show

pLit :: Parser Exp
pLit = Lit <$> decimalNumber <* ws

pParen :: Parser Exp
pParen = char' '(' *> pLowest <* char' ')'

pAtom :: Parser Exp
pAtom = pLit <|> pParen

pMult :: Parser Exp
pMult = rightAssoc Mult pAtom (char' '*')

pPlus :: Parser Exp
pPlus = rightAssoc Plus pMult (char' '+')

pLt :: Parser Exp
pLt = nonAssoc Lt pPlus (char' '<')

pEq :: Parser Exp
pEq = nonAssoc Eq pLt (string' "==")

pLowest :: Parser Exp
pLowest = pEq

pExp :: Parser Exp
pExp = topLevel pLowest

evalExp :: Exp -> Int
evalExp (Lit i) = i
evalExp (Plus l r) = evalExp l + evalExp r
evalExp (Mult l r) = evalExp l * evalExp r
evalExp (Lt l r) = case evalExp l < evalExp r of
  True -> 1
  False -> 0
evalExp (Eq l r) = case evalExp l == evalExp r of
  True -> 1
  False -> 0


evalString :: String -> Int
evalString = maybe (error "Invalid expression") evalExp . evalParser pExp


{- Tasks -}

-- Extend the parser and evaluator above with a non-associative "less than" (<)
-- and a non-associative "equality check" (==) operator! The "less than"
-- operator should have stronger precedence than "equality check", and both
-- should be weaker than all of the previously defined operators.
-- [So the list in increasing order of precedence is: (==), (<), (+), (*)]
-- Since our expression language has no boolean values, the results of these
-- operations should be represented using the so called "C-style", where
-- the number 0 means False and the number 1 means True.

-- Tests:
-- ∙ evalString "12 + 34"              == 46
-- ∙ evalString "5 * 6"                == 30
-- ∙ evalString "5 * 6 + 7"            == 37
-- ∙ evalString "5 * (6 + 7)"          == 65
-- ∙ evalString "8 == 9"               == 0
-- ∙ evalString "(3 + 4) * 2 == 6 + 8" == 1
-- ∙ evalString "10 < 0"               == 0
-- ∙ evalString "99 < 100"             == 1
-- ∙ evalString "1 * 1 < 1 + 1"        == 1
-- ∙ evalString "2 * 2 < 2 + 2"        == 0
-- ∙ evalString "2 < 3 == 4 < 5"       == 1
-- ∙ evalString "(5 == 5) < 1"         == 0
