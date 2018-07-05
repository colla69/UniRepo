
-- data Frucht = Frucht Sorte Int Int

-- data Frucht = Apfel (Int,Int)
--             | Birne Int Int
--             | Banane Int Int Double

-- data Sorte = Apfel | Birne | Banane Double
-- }

-- data Frucht = Apfel { preis::Int, anzahl::Int } -- 2 Arg.
-- | Birne { preis,
-- anzahl::Int } -- 2 Arg.
-- | Banane { preis::Int, anzahl::Int
-- , krümmung::Double
-- } -- 3 Arg.

data Frucht = Apfel { preis::Int, anzahl::Int}| 
 Birne { preis::Int, anzahl::Int}|
 Banane { preis::Int, anzahl::Int, krümmung::Double }