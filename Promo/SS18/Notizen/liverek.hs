-- VORLESUNG Programmierung und Modellierung
-- DEMO 23.04.18
--
-- Zur Vermeidung von Namenskonflikten mit
-- der Standardbibliothek wurden Funktionen
-- ggf. mit Vorsilbe "my" unbenannt,
-- also "drop" wurde zu "myDrop", etc.
--

-- Kochrezept: Signatur hinschreiben, Basisfälle abhandeln, knifflige Fälle behandeln, vereinfachen
myDrop :: Int -> [a] -> [a]
myDrop  0  liste = liste -- Basisfall
myDrop  _     [] = []    -- Basisfall
myDrop wwz (_:restliste) = myDrop (wwz-1) restliste -- rekursiver Fall (erfordert Nachdenken)

-- Was passiert bei negativem Argument wwz?
-- Abstiegsfunktion?

----------------------------------


myReverse :: [a] -> [a]
-- Endrekursive Version als Übung lassen! Okay!
myReverse = undefined -- TODO


----------------------------------

-- Annahme: das 2. Argument ist sortiert!!!
insert :: Int -> [Int] -> [Int]
insert elem     []              = elem:[]
insert elem l@(h:t) | elem <= h = elem:l
                    | otherwise = h   :(insert elem t)
-- alternativ mit einem Zwischenschritt:
--       let kleinereSortierteListeMitElem = insert elem t
--       in  h:kleinereSortierteListeMitElem


sort :: [Int] -> [Int]
sort []    = []
sort (h:t) = insert h (sort t)

-- Abstiegsfunktionen für insert/sort?

----------------------------------


myZip :: [a] -> [b] -> [(a,b)]
myZip    []      _  = []
myZip     _     []  = []
myZip (x:xs) (y:ys) = (x,y):(myZip xs ys)
-- Begonnen hatten wir erst mal ganz stumpfsinnig mit:
--myZip    []     []  = []
--myZip    []  (y:ys) = []
-- ...was wir dann nachträglich zu obiger Version vereinfachten.

-- Abstiegsfunktionen für myZip?
-- Qualitative Unterschiede zwischen Abstiegsfunktionen?
