module Bonus (eintragPunkte, eintragAbschreiber, punkteAuslesen, leer) where

import qualified Data.Map as Map

data Bonus = Punkte [Int] | Abschreiber deriving Show

type Student = String -- zur Vereinf_{1}achung; sonst besser data verwenden
type Register = Map.Map Student Bonus 

leer :: Register
leer = Map.empty

summeBonus :: Bonus -> Int
summeBonus (Abschreiber) = 0
summeBonus (Punkte []) = 0
summeBonus (Punkte (p:rest)) | (p == 0) = 0
                             | otherwise = p + summeBonus (Punkte rest)

punkteSummieren :: Maybe Bonus -> Int
punkteSummieren Nothing = 0
punkteSummieren (Just bonus) = summeBonus bonus

punkteAuslesen :: Student -> Register -> Int
punkteAuslesen a ds = punkteSummieren (Map.lookup a ds)

eintragAbschreiber :: Student -> Register -> Register
eintragAbschreiber student reg = eintragPunkte student 0 reg

bonusToInt :: Maybe Bonus ->[Int]
bonusToInt Nothing = []
bonusToInt (Just a) = getPunkte a 
 where getPunkte :: Bonus -> [Int]
       getPunkte Abschreiber = [0]
       getPunkte (Punkte p) = p

eintragPunkte :: Student -> Int -> Register -> Register
eintragPunkte student 0 ds = Map.insert student Abschreiber ds
eintragPunkte student punkte ds = 
        if ((bonusToInt (Map.lookup student ds)) == [0]) 
          then Map.insert student Abschreiber ds
          else Map.insert student (Punkte (punkte:bonusToInt(Map.lookup student ds))) ds

 
-- TEST
r1 = eintragPunkte "Martin" 8 (eintragPunkte "Steffen" 4 leer) 
r2 = eintragAbschreiber "Martin" (eintragPunkte "Steffen" 6 r1)
r3 = eintragPunkte "Martin" 12 (eintragPunkte "Steffen" 2 r2)
steffentest :: Int
steffentest = punkteAuslesen "Steffen" r3
martintest :: Int
martintest = punkteAuslesen "Martin" r3
