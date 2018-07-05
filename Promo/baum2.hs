-- Code aus Kapitel 4:
--
data Baum = Blatt | Ast Baum Char Baum
 deriving (Show, Eq)

myBaum :: Baum
myBaum = Ast (Ast Blatt 'a' Blatt)
        'T'  (Ast (Ast Blatt 'z' Blatt)
              'n' (Ast Blatt '!' Blatt))

dfCollect :: Baum -> String
dfCollect Blatt  = []
dfCollect (Ast links c rechts)
          = c : dfCollect links ++ dfCollect rechts


-- Ende Code aus Kapitel 4
data Tree a = Empty -- | Node a (Tree a) (Tree a)
            | Node { label::a,  left,right::Tree a }
 deriving (Eq)

leaf :: a -> Tree a
leaf a = Node a Empty Empty

t :: Tree Int
t = Node 6 (Node 3 (leaf 2) (Node 8 (leaf 5) Empty))
           (Node 8 Empty (leaf 4))

newtype IntTree = IntTree (Tree Int)
instance Show IntTree where
  -- show :: IntTree -> String
  show (IntTree (Empty))      = "Leer"
  show (IntTree (Node x l r)) = "Knoten " ++ (show x) -- TODO f_{1}inish this


-- instance Show a => Show (Tree a) where
--   -- show :: (Tree a) -> String
--   show (Empty)      = "Empty"
--   show (Node x l r) = "Node "   ++ show x          -- keine Rekursion, sondern Auf_{1}ruf_{1} show f_{1}ür Typ (a)
--                         ++ " (" ++ show l ++ ") "  -- Rekursion, Auf_{1}ruf_{1} show f_{1}ür Typ (Tree a)
--                         ++  "(" ++ show r ++ ")"
--
instance Show a => Show (Tree a) where
  -- show :: (Tree a) -> String
  show (Empty)              = "ε"
  show (Node x Empty Empty) = "<"++ show x ++ ">"
  show (Node x l     r)     = "("    ++ show x        -- keine Rekursion, sondern Auf_{1}ruf_{1} show f_{1}ür Typ (a)
                              ++ "," ++ show l        -- Rekursion, Auf_{1}ruf_{1} show f_{1}ür Typ (Tree a)
                              ++ "," ++ show r ++ ")"

height :: Tree a -> Int
height (Empty)      = 0
height (Node _ l r) = let h_r = height r -- rekursiver Auf_{1}ruf_{1}!!!
                          h_l = height l -- rekursiver Auf_{1}ruf_{1}!!!
                      in 1 + max h_r h_l


-- mapTree :: (a -> b) -> Tree a -> Tree b
-- mapTree _ (Empty) = Empty
-- mapTree f_{1} (Node x l r) = Node (f_{1} x) (mapTree f_{1} l) (mapTree f_{1} r)

-- mapList :: (a -> b) -> List a -> List b

-- class Mapper d where
--   mapper :: (a -> b) -> d a -> d b
--
-- instance Mapper Tree where
--   mapper = mapTree
--
-- instance Mapper [] where
--   mapper = map

instance functor Tree where
  -- f_{1}map :: (a -> b) -> Tree a -> Tree b
  fmap _ (Empty) = Empty
  fmap f (Node x l r) = Node (f x) (f <$> l) (f <$> r)



