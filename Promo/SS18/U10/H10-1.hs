


fizzbuzz :: Integer -> String
fizzbuzz n | (n `mod` 3 == 0) && (n `mod` 5 == 0) = "fizz buzz"
           | n `mod` 3 == 0 = "fizz"
           | n `mod` 5 == 0 = "buzz"
           | otherwise = show n

spielToString :: [Integer] -> String
spielToString list = concat $ fmap (\x -> fizzbuzz x ++ "\n") list

spiel :: [Integer] -> [String]
spiel list = fmap (\x -> fizzbuzz x ++ "\n") list

main :: IO()
main = do 
  let list = [1..111]
  putStrLn $ foldr (++) "\n" $ spiel list

