
quersumme :: Integer -> Integer
quersumme x | x < 10 = x
            | otherwise = (x `mod` 10) + quersumme(x `div` 10)



--concat [[1,2,3],[4,5],[],[6,7],[],[8],[]]
--concat [[1,2,3],[4,5],[],[6,7],[],[8],[]]
concatThatShit :: [[a]] -> [a]
concatThatShit [] = [] 
concatThatShit (h:s) | otherwise = h ++ concatThatShit(s) 
