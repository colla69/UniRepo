


safeIndex :: [b] -> Integer -> Maybe b
safeIndex [] _ = Nothing 
safeIndex list n = get list n 0 where
	get :: [b] -> Integer -> Integer -> Maybe b
 	get [] _ _= Nothing 
 	get (a:rest) n ix | n == ix = Just a
 					  | otherwise = get rest n (ix+1)