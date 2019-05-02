magic :: Integer -> Integer -> Integer -> String
magic a b c | even c, b > 0, a < 0 = 'x' : (magic (1+a) b
(1+c))
| odd c, b > 0, a < 0 = 'y' : (magic
a (b-1) (c+1))
| otherwise
= show c