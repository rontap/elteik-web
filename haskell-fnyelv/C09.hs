{-# language InstanceSigs, DeriveFunctor #-}
{-# options_ghc -Wincomplete-patterns #-}
module C09 where

import Control.Monad
import Control.Applicative
import Data.Char
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

-- number parsing

-- Digit character with numeric value
digit :: Parser Int
digit = digitToInt <$> satisfy isDigit

-- Convert a list of digits into a number
digitsToNumber :: Int -> [Int] -> Int
digitsToNumber base = foldl (\acc curr -> acc * base + curr) 0

-- Non-negative decimal integer number
decimalNumber :: Parser Int
decimalNumber = digitsToNumber 10 <$> some digit


{- Tasks -}


-- Task 1: Create a parser that extracts data from music filenames of the
--         following format:
--
-- (year)_(artist)-(title).(extension)
--   where
--     year          : [0-9]+
--     artist, title : [a-z]+
--     extension     : flac|mp3
--
-- Examples:
-- + evalParser music "2010_pendulum-encoder.flac"
--   == Just (MkMusic 2010 "pendulum" "encoder" Lossless)
-- + evalParser music "2011_coldplay-paradise.mp3"
--   == Just (MkMusic 2011 "coldplay" "paradise" Lossy)
-- + evalParser music "2012_muse-madness.flac"
--   == Just (MkMusic 2012 "muse" "madness" Lossless)
-- + evalParser music "2013_adele-skyfall.mp3"
--   == Just (MkMusic 2013 "adele" "skyfall" Lossy)
-- + evalParser music "???.jpg"
--   == Nothing

toInt values base = foldl (\acc curr -> acc * base + curr) 0 (map digitToInt values)

posInt :: Parser Int
posInt = do
   val <- some (inList ['0'..'9'])
   return (toInt val 10)



data Quality = Lossless | Lossy deriving (Eq, Show)
data Music = MkMusic
  { year :: Int
  , artist :: String
  , title :: String
  , quality :: Quality
  } deriving (Eq, Show)

music :: Parser Music
music = do
  yr <- posInt
  char '_'
  a <- some $ inList ['a'..'z']
  char '-'
  b <- some $ inList ['a'..'z']

  typ <- Lossy <$ string ".mp3" <|> Lossless <$ string ".flac"
  return (MkMusic yr a b typ)


-- Task 2: Create a parser that extracts data from image filenames of the
--         following format:
--
-- (tag)-(tag)-...-(tag)_(width)x(height).jpg
--   where
--     tag           : [a-z]+
--     width, height : [0-9]+
--
-- Examples:
-- + evalParser image "cat-dog-mouse_640x480.jpg"
--   == Just (MkImage ["cat", "dog", "mouse"] 640 480)
-- + evalParser image "sunset-landscape_1920x1080.jpg"
--   == Just (MkImage ["sunset", "landscape"] 1920 1080)
-- + evalParser image "_1280x720.jpg"
--   == Just (MkImage [] 1280 720)
-- + evalParser image "car_320x1440.jpg"
--   == Just (MkImage ["car"] 320 1440)
-- + evalParser image "???.mp3"
--   == Nothing

data Image = MkImage
  { tags :: [String]
  , width :: Int, height :: Int
  } deriving (Eq, Show)

image :: Parser Image
image = do
    ar <- (some $ (many $ inList ['a'..'z']) >> char '-')
   -- arl <- many $ inList ['a'..'z']
    char '_'
    w <- posInt
    char 'x'
    h <- posInt
    string ".jpg"
    return (MkImage ["cat"] w h)