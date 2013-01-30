module GTD.CLParser.Combinators (
  (>>>),
  (<+>), (<-+>), (<+->),
  (<=>)
 ) where


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
  if p a 
  then return (cs', a) 
  else Left ("Can't parse: " ++ cs)
