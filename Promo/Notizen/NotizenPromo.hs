fib :: Integer -> Integer
fib n 
  | n <= 1 = 1
  | otherwise = fib (n-1) + fib (n-2)

trinum n = n + trinum (n-1)



insert :: Int -> [Int] -> [Int]
insert elem [] = elem:[]
insert elem l@(h:t) 
  | elem <= h 
  | otherwise = h : (insert elem t)



sort :: [Int] -> [Int]
sort [] = []
sort (h:t) = insert h (sort t)

myZip
