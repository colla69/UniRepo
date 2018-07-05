module Test where


import Data.List.Split 

data Term = Var Char | Const Int | App Term Term | Abs Char Term

instance Show Term where
  show a = freeVars a

genFreshV :: [Char] -> Char
genFreshV vs = head $ filter (\c -> not $ c `elem` vs) ['a'..'z']


freeVars :: Term -> [Char]
freeVars (Var x) = [x]
freeVars (Const _) = []
freeVars (App e1 e2) = (freeVars e1) ++ (freeVars e2)
freeVars (Abs x e1) = filter (/=x) (freeVars e1)

iffy :: Applicative f => f Bool -> f a -> f a -> f a
iffy fb ft ff = cond <$> fb <*> ft <*> ff
  where cond b t f = if b then t else f

subst :: (Char, Term) -> Term -> Term
subst (x,e) o@(Var y) | x == y = e
                      | otherwise = o --(Var y)
subst (x,e) (Const c) = Const c
subst s o@(App e1 e2) = App (subst s e1) (subst s e2)
subst s@(x,e) o@(Abs y e1)
    | x == y = o
    | y `elem` fv_e = Abs freshV (subst (x,e) $ subst (y, Var freshV) e1)
    | otherwise = Abs y (subst s e1)
        where
        fv_e = freeVars e
        fv_e1 = freeVars e1
        freshV = genFreshV (fv_e ++ fv_e1)

getI :: [Int] -> Int -> [[Int]] -> (Int -> Int -> Int)-> Int
getI a n [] _ = a!!n
getI a n (b:rest) f = (a!!n) + getI b (f n 1) rest f

blupp a n = a!!n 

diagonalDifference :: [[Int]] -> Int
diagonalDifference (a:rest) = i
 where i = (getI a 0 rest (+)) 
       j = (getI a ((length a)-1) rest (-)) 
        

--test
t1 = (App (Abs 'a' (Var 'n'))(App (App (Var 'd') (Var 'r')) (App (Var 'e') (Var 'a') )))
test1 = putStrLn $ freeVars t1
t2 = (App (Abs 'a' (Const 1))(App (App (Const 2) (Var 'r')) (App (Var 'e') (Var 'a') )))
test2 = putStrLn $ freeVars t2




zero :: (Int, Int,Int) -> String
zero (a,b,0) = "0"
zero (a,b,c) = show ((fromIntegral(a+b+c))/(fromIntegral c))


nosum :: [Int] -> Int -> Int -> Int
nosum [] _ _ = 0
nosum (a:rest) n ix | n == ix = 0+ (nosum rest n (ix+1))
                    | otherwise = a + (nosum rest n (ix+1))


convert _ [] = ""
convert "A" (a:rest) = a ++":"++ convert "A" rest
convert "P" (a:rest) 
 | a == "1" =  "13" ++":"++ convert "A" rest
 | a == "2" =  "14" ++":"++ convert "A" rest
 | a == "3" =  "15" ++":"++ convert "A" rest
 | a == "4" =  "16" ++":"++ convert "A" rest
 | a == "5" =  "17" ++":"++ convert "A" rest
 | a == "6" =  "18" ++":"++ convert "A" rest
 | a == "7" =  "19" ++":"++ convert "A" rest
 | a == "8" =  "20" ++":"++ convert "A" rest
 | a == "9" =  "21" ++":"++ convert "A" rest
 | a == "10" =  "22" ++":"++ convert "A" rest
 | a == "11" =  "23" ++":"++ convert "A" rest
 | a == "12" =  "00" ++":"++ convert "A" rest
 | otherwise =  "kaka"
   
 
timeConversion :: [Char] -> String
timeConversion s = reverse $ tail $ tail $ tail $ reverse $convert [(s!!((length s)-2))] $ splitOn ":" s

aaa = [73,67,38,33]


abstandTo :: Integer -> Integer -> Integer
abstandTo a n | a `mod` 5 == 0 = n
              | a `mod` 5 /= 0 = 0+(abstandTo (a+1) (n+1))

nextDivisible :: Integer -> Integer
nextDivisible n | n `mod` 5 == 0 = n
                | n `mod` 5 /= 0 = nextDivisible (n+1)

gradingStudents :: [Integer] -> [Integer]
gradingStudents [] = []
gradingStudents (a:rest) 
  | a `mod` 5 == 0 = a:(gradingStudents rest)
  | a `mod` 5 /= 0 = if (abstandTo (nextDivisible a) 0) <=3 
                        then (nextDivisible a):(gradingStudents rest)
                        else a:(gradingStudents rest)


sumHG :: [Int] -> [Int] -> [Int] -> [[Int]] 
sumHG [] [] [] = [[]]
sumHG (a1:a2:a3:arest) (z:b:brest) (c1:c2:c3:crest) = 
  if ((length arest) > 0) 
    then [c1:c2:c3:b:a1:a2:a3:[]] ++ (sumHG (a2:a3:arest) (b:brest) (c2:c3:crest))
    else [c1:c2:c3:b:a1:a2:a3:[]]
