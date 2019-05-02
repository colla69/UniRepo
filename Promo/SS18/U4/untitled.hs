
safeIndex :: [b] -> Integer -> Maybe b
safeIndex list n = getIndex list n 0
 where 
        getIndex :: [b] -> Integer -> Integer -> Maybe b
        getIndex []     _ _     = Nothing
        getIndex a:rest n count | a==n = count+1
                                | getIndex (a:rest) n (count+1)