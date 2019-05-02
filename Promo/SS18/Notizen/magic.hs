magic :: Integer -> Integer -> Integer -> String
magic a b c | even c, b > 0, a < 0 = 'x' : (magic (1+a) b (1+c))
            | odd c, b > 0, a < 0 = 'y' : (magic a (b-1) (c+1))
            | otherwise = show c



isRight :: Either a b -> Bool
isRight (Left _) = False
isRight (Right _) = True

lefts :: [Either a b] -> [a]
lefts x = [a | Left a <- x]

partitionEithers :: [Either a b] -> ([a],[b])
partitionEithers [] = ([],[])
partitionEithers (h : t) =
    let (ls,rs) = partitionEithers t
    in case h of Left l -> (l:ls, rs)
                 Right r -> ( ls, r:rs)


data Muster = Muster {a :: Int, b :: Int , c:: Int}



-- newtype FirstName = FirstName String

-- instance ord Muster  

test :: Muster -> n -> Muster -> [Bool]
test    m n   m2 = (erfolg(m.a , m.b, m.c) n (m2.a , m2.b, m.2c):[]


