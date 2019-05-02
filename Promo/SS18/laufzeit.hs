-- Laufzeitbetrachtungen, ProMo Vorlesung 28.05.2018
-- Steffen Jost, IfI, LMU München

revAcc :: [a] -> [a] -> [a]
revAcc acc []    =  acc
revAcc acc (x:l) =  revAcc (x:acc) l

revSpec :: [a] -> [a]
revSpec []     =  []
revSpec (x:l)  =  revSpec l ++ [x]


test :: ([Int] -> [a]) -> Int -> Int
test f n = length $ f [n,n-1..1]

t3a = test (revAcc []) 30000
t3b = test (revSpec)   30000

testliste :: [Init]
testliste = -- teure Berechnung

test1 = teste f1 testliste -- kosten für testliste fallen an
test2 = teste f2 testliste -- testliste kostet nix mehr, Messung verfälscht


-- Nur eins von beiden einkommentieren:
main = print t3a
-- main = print t3b




--

filterAcc :: [a] -> (a->Bool) -> [a] -> [a]
filterAcc acc p [] = acc
filterAcc acc p (x:l)
  | p x       = filterAcc (acc++[x]) p l
  | otherwise = filterAcc  acc       p l

filterSpec :: (a->Bool) ->  [a] -> [a]
filterSpec p [] = []
filterSpec p (x:l)
  | p x       = x:filterSpec p l
  | otherwise =   filterSpec p l




-- Sortieren




insertel :: Ord a => a -> [a] -> [a]
insertel x []    = [x]
insertel x (y:l) = if x <= y then x:y:l
                             else y:insertel x l

inssort :: Ord a => [a] -> [a]
inssort [] = []
inssort (x:l) = insertel x  (inssort l)





quicksort :: [Int] -> [Int]
quicksort   []  = []
quicksort (h:t) =
    (quicksort smaller) ++ [h] ++ (quicksort bigger)
  where
    (smaller,bigger) = splitBy h t

splitBy :: Int -> [Int] -> ([Int],[Int])
splitBy _ []    = ([],[])
splitBy p (h:t) | h <= p    = (h:smaller,   bigger)
                | otherwise = (  smaller, h:bigger)
  where
    (smaller,bigger) = splitBy p t





mergesort :: Ord a => [a] -> [a]
mergesort []  = []
mergesort [a] = [a]
mergesort l   = merge (mergesort l1)  (mergesort l2)
      where (l1,l2) = split l
            split :: [a] -> ([a],[a])
            split []  = ([],[])
            split [a] = ([a],[])
            split (a:b:u) = (a:u1,b:u2)
                  where (u1,u2) = split u
            merge :: Ord a => [a] -> [a] -> [a]
            merge   []    []  = []
            merge   []     u  = u
            merge    u    []  = u
            merge (x:u) (y:v)
              | x<= y     = x:merge    u  (y:v)
              | otherwise = y:merge (x:u)    v
