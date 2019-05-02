{-
a1

1
1
2
1
-}

--a2


summe :: [Int] -> Int
summe a = foldl (+) 0  a


summe' :: [Int] -> Int
summe' a = foldl (\x y -> if y<0 then x+0 else x+y ) 0 a 


summe'' :: [Int] -> Int
summe'' [] = 0
summe'' (a:rest) | a < 0 = 0+(summe'' rest)
                 | otherwise = a+(summe'' rest)


