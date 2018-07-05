


-- entferne 7 [4,5,6,7,7,8,9,8,7,6,7,4,7]
-- [4,5,6,8,9,8,6,4]

entferne :: Int -> [Int] -> [Int]
entferne  _ [] = []
entferne  n l = remove n l []
    where   remove :: Int -> [Int] -> [Int] -> [Int]
            remove _ [] return = return        
            remove n (e:rest) return = 
                if n==e 
                    then remove n rest return 
                    else remove n rest (return++[e])   

umdrehen :: [a] -> [a]
umdrehen [] = []
umdrehen list = swap list []
    where swap :: [a] -> [a] -> [a]
          swap [] return = return
          swap (e:rest) return = swap rest (e:return)