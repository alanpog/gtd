module GTD.CLParser.Primitives ( 
  Parser(..),
  (>>>),
  (<+>), (<-+>), (<+->),
  (<=>)
 ) where

import Control.Monad
import Control.Monad.Instances
import Data.Char

type Parser a = String -> Maybe (String, a)


-- | Parse a single character
char :: Parser Char
char []     = Nothing
char (c:cs) = Just (cs, c)


-- | Parse a single decimal digit
digit :: Parser Int
digit = char <=> isDigit >>> digitToInt


-- | Parse a single letter
letter :: Parser Char
letter = char <=> isLetter


-- | Parse a whitespace
space :: Parser Char
space = char <=> isSpace 


-- | Parse a given character
literal :: Char -> Parser Char
literal l = char <=> (==l)


-- | Create parse with a given result
result :: a -> Parser a
result a cs = return (cs, a)


-- | Iterate a parser until it fails
iter :: Parser a -> Parser [a]
iter m = m <+> iter m >>> cons <|> result []


-- | Iterate parser at least once until it fails
iter' :: Parser a -> Parser [a]
iter' m = m <+> iter m >>> cons <|> failed


-- | Cause parse failure
failed :: Parser a
failed _ = Nothing


-- | Colapse a tuple into a list
cons :: (a, [a]) -> [a]
cons (hd, tl) = hd:tl



infixl 3 <|>
(<|>) :: Parser a -> Parser a -> Parser a
(m <|> n) cs = case m cs of
    Nothing -> n cs
    mcs     -> mcs


infixl 5 >>>
(>>>) :: Parser a -> (a -> b) -> Parser b
(m >>> f) cs = liftM (fmap f) (m cs)


infixl 6 <+>
(<+>) :: Parser a -> Parser b -> Parser (a, b)
(m <+> n) cs = do
  (cs',  a) <- m cs
  (cs'', b) <- n cs'
  return (cs'', (a, b))


infixl 6 <-+>
(<-+>) :: Parser a -> Parser b -> Parser b
(m <-+> n) cs = do
  (cs',  _) <- m cs
  (cs'', b) <- n cs'
  return (cs'', b)


infixl 6 <+->
(<+->) :: Parser a -> Parser b -> Parser a
(m <+-> n) cs = do
  (cs',  a) <- m cs
  (cs'', _) <- n cs'
  return (cs'', a)


infix 7 <=>
(<=>) :: Parser a -> (a -> Bool) -> Parser a
(m <=> p) cs = do
  (cs', a) <- m cs
  if p a then return (cs', a) else Nothing
