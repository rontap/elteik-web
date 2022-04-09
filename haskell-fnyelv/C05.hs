{-# options_ghc -Wincomplete-patterns #-}
module C05 where

-- Define a password entry function that requires a minimum length of eight
-- characters and ensures that the same
-- string is entered twice in succession!
-- ps.: Since we only looked at `IO ()` functions last time,
-- you don't need to
--      return the value.

passwordInput :: IO ()
passwordInput = do
  putStrLn "Write pw"
  pw <- getLine
  if length pw < 8 then do
    putStrLn "Too Short"
    passwordInput
    else do
      pw2 <- getLine
      if pw == pw2 then putStrLn "Successs" else do
        putStrLn "Not Same"
        passwordInput

-- Examples:
-- ∙ > 12345678
--   > 12345678
--   "Success!"
--
-- ∙ > sajt
--   "Too short!"
--   > valami
--   "Too short!"
--   > szendvics
--   > sandwich
--   "Not the same!"
--   > password
--   > password
--   "Success!"