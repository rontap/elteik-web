{-# language InstanceSigs, DeriveFunctor #-}
{-# options_ghc -Wincomplete-patterns #-}
module C10 where

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


{- Task: Boolean expressions -}

-- Write a parser that reads simple boolean expressions containing
-- literals ("T" or "F"), parentheses, conjunction ("v") and disjunction ("^")!
--
-- Conjunction and disjuction should both associate to the right and
-- conjunction should have higher precedence.

data BExp
  = Lit Bool      -- "T" or "F"
  | And BExp BExp -- "l ^ r"
  | Or BExp BExp  -- "l v r"
  deriving (Show)

pBool :: Parser Bool
pBool = True <$ char' 'T' <|> False <$ char' 'F'

pLits :: Parser BExp
pLits = Lit <$> pBool <* ws

pParen :: Parser BExp
pParen = char' '(' *> pDisj <* char' ')'

pAtom :: Parser BExp
pAtom = pLits <|> pParen

pConj :: Parser BExp
pConj = rightAssoc Or pAtom (char' 'v')

pDisj :: Parser BExp
pDisj = rightAssoc And pConj (char' '^')

bExp :: Parser BExp

bExp = topLevel pDisj


-- Tests:
-- ∙ evalParser bExp "F"
--   == (Lit False)
-- ∙ evalParser bExp "(T)"
--   == (Lit True)
-- ∙ evalParser bExp "T v T ^ F"
--   == (Or (Lit True) (And (Lit True) (Lit False)))
-- ∙ evalParser bExp "(T v T) ^ F"
--   == (And (Or (Lit True) (Lit True)) (Lit False))
-- ∙ evalParser bExp "T v F ^ F v T"
--   == (Or (Lit True) (Or (And (Lit False) (Lit False)) (Lit True)))
-- ∙ evalParser bExp "T ^ F v F ^ T"
--   == (Or (And (Lit True) (Lit False)) (And (Lit False) (Lit True)))
-- ∙ evalParser bExp "T ^ T ^ F ^ T"
--   == (And (Lit True) (And (Lit True) (And (Lit False) (Lit True))))
-- ∙ evalParser bExp "T v F v T v T"
--   == (Or (Lit True) (Or (Lit False) (Or (Lit True) (Lit True))))

evalBExp :: BExp -> Bool
evalBExp be = undefined

-- Tests:
-- ∙ evalBExp (Lit False)                                                    == False
-- ∙ evalBExp (Lit True)                                                     == True
-- ∙ evalBExp (Or (Lit True) (And (Lit True) (Lit False)))                   == True
-- ∙ evalBExp (And (Or (Lit True) (Lit True)) (Lit False))                   == False
-- ∙ evalBExp (Or (Lit True) (Or (And (Lit False) (Lit False)) (Lit True)))  == True
-- ∙ evalBExp (Or (And (Lit True) (Lit False)) (And (Lit False) (Lit True))) == False
-- ∙ evalBExp (And (Lit True) (And (Lit True) (And (Lit False) (Lit True)))) == False
-- ∙ evalBExp (Or (Lit True) (Or (Lit False) (Or (Lit True) (Lit True))))    == True

evalString :: String -> Bool
evalString = evalBExp . fand romJust . evalParser bExp

-- Tests:
-- ∙ evalString "F"             == False
-- ∙ evalString "(T)"           == True
-- ∙ evalString "T v T ^ F"     == True
-- ∙ evalString "(T v T) ^ F"   == False
-- ∙ evalString "T v F ^ F v T" == True
-- ∙ evalString "T ^ F v F ^ T" == False
-- ∙ evalString "T ^ T ^ F ^ T" == False
-- ∙ evalString "T v F v T v T" == True
