{- Übung H10-2 zur Vorlesung "Programmierung und Modellierung"
   Lehrstuhl für theoretische Informatik, LMU München
   Steffen Jost, Leah Neukirchen
-}

import Control.Monad


chainAction1 :: Monad m => a -> [(a -> m a)] -> m a
chainAction1 n flist@(f:restf) = do 
        result <- f n
        if (length restf) /= 0
            then chainAction1 result restf
            else return result 

chainAction2 :: Monad m => a -> [(a -> m a)] -> m a
chainAction2 n (f:[]) = f n
chainAction2 n flist@(f:restf) = 
  f n >>= (\x -> chainAction2 x restf)          

chainAction3 :: Monad m => a-> [(a -> m a)] -> m a
chainAction3 n flist = foldM (\x -> (\f -> f x)) n flist

tellOp :: (Show a, Show b) => (a -> b) -> a -> IO b
tellOp f x = let fx = f x in do
  putStrLn $ (show x) ++ " -> " ++ (show fx)
  return fx
  
test1 :: [Int -> IO Int]  
test1 = map tellOp [(*3),(+1),(`mod` 7),(+5),(*2)]
  
test2 :: [Int -> IO Int] --der Neugier :)
test2 = map tellOp [(*3),(+1),(`mod` 7),(`div` 0),(*2)]