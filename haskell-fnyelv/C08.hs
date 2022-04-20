{-# language InstanceSigs, DeriveFunctor #-}
{-# options_ghc -Wincomplete-patterns #-}
module C08 where

import Control.Monad
import Control.Applicative
import Data.Char
import Debug.Trace

-- PARSER LIBRARY
--------------------------------------------------------------------------------

newtype Parser a = Parser {runParser :: String -> Maybe (a, String)}
  deriving (Functor)

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

--------------------------------------------------------------------------------

{- Example -}

-- Parser, that matched hexadecimal number literals of the followig format:
--
-- 0x[0-9A-F]+$
--
-- Valid examples:
-- + "0x0"
-- + "0xFA55B8"
--
-- Invalid examples:
-- + "1337"
-- + "0x1Q34"

p0 :: Parser ()
p0 = string "0x" >> some (inList (['0'..'9'] ++ ['A'..'F'])) >> eof



{- Tasks -}

-- Task 1: Create an parser that accepts (potentially fictive) Haskell version
-- names of the following format:
--
-- Haskell(\d*)$
--
-- Valid examples:
-- ∙ "Haskell"
-- ∙ "Haskell98"
-- ∙ "Haskell2010"
-- ∙ "Haskell2035"
--
-- Invalid examples:
-- ∙ "Haskellabc"
-- ∙ "Haksell98"
-- ∙ "haskell2010"
-- ∙ "Haskell2035asdf"

p1 :: Parser ()
p1 = string "Haskell" >> many  (inList ['0'..'9']) >> eof


-- Task 2: Create a parser that matches the beginning (protocol and domain part)
--         of a hungarian or commercial URL of the following format:
--
-- https?://([a-z]+\.)+(hu|com)
--
-- Valid examples:
-- ∙ "https://google.com"
-- ∙ "https://maps.google.com"
-- ∙ "http://www.elte.hu/news"
-- ∙ "http://people.inf.elte.hu"
--
-- Invalid examples:
-- ∙ "http://.hu"
-- ∙ "http://inf..elte.hu"
-- ∙ "http://wikipedia.org"
-- ∙ "ftp://elte.hu"

p2 :: Parser ()
p2 = string "http" >>  optional (char 's') >> string "://" >> some(( some (inList ['a'..'z']) ) >> char '.') >> (string "hu" <|> string "com" )

