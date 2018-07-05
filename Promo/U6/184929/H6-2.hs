
myLength :: [a] -> Int
myLength a = foldl  ( \x y -> x+1) 0 a

myReverse :: [a] -> [a]
myReverse a = foldl (\x y -> y:x ) [] a