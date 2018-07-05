-- Code aus ProMo Vorlesung 14.05.2018
-- Steffen Jost, LMU München

f1 :: Int -> (Int -> Int)
--   Arg1    Arg2   Ergebnistyp
f1 x y = x+y


f2 :: Int -> Int
f2 x = x+1    -- x::Int


f3 :: (Int -> Int) -> Int
--        Arg1     Ergebnistyp
f3 g = g 0                     -- g :: Int -> Int



twice :: (a -> a) -> (a -> a)
twice f = \x -> f (f x)

twice' :: (a -> a) -> a -> a
twice' f x = f (f x)


myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith _    []      _  = []
myZipWith _     _     []  = []
myZipWith f (x:xs) (y:ys) =
  let z = f x y
  in z : (myZipWith f xs ys)


myZip :: [a] -> [b] -> [(a,b)]
myZip a b = myZipWith (,) a b


myfoldr :: (a -> b -> b) -> b ->   [a]       -> b
--               f         acc   h:a t::[a]
myfoldr _ acc   []  = acc
myfoldr f acc (h:t) = f h (myfoldr f acc t)
-- Ursprünglich falscher Code (implementiert wie foldl):
  -- let x = f h acc
  -- in  myfoldr f x t

binUnd :: Bool -> Bool -> Bool -- bekannt als (&&)
binUnd false _   = False --- guter fall für foldr !
binUnd _ false   = False
binUnd True True = True
 
-- Einfacher auch durch:
-- binUnd' True True = True
-- binUnd' _     _   = False




compose :: (b -> c) -> (a -> b) -> a -> c
compose bc ab a = let b = ab a in
              let c = bc b in c



--- Abschnitt


data Frucht = Frucht {sorte::Sorte, preis,anzahl::Int} deriving Show
data Sorte  = Apfel | Birne | Banane Double            deriving Show

preise :: [Frucht] -> [Int]
preise []     = []
preise (f:fs) = preis f : preise fs

euro :: Int -> String
euro p = (show p) ++ "€"

toEuros :: [Int] -> [String]
toEuros []     = []
toEuros (p:ps) = (euro p):(toEuros ps)
