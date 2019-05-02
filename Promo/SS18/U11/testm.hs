



----------------------------------------------------------------------------
-- Vorlage für Übung H11-3 zur Vorlesung "Programmierung und Modellierung"
-- am 3.07.2018 an der LMU München
-- verfasst von Simon Weinzierl & Steffen Jost
--

{-
  HINWEISE:

  Beschleunigen Sie die Berechnung von slowFactor mit Hilfe der par-Monade!

  Sie müssen lediglich den dafür angelegten Dummy "parallelFactorisation"
  neu programmieren (und ggf. Hilfsfunktionen),
  sonst muss nichts am Code verändert werden!

  Ziel:


  Um das Programm mit Verwendung von bis zu 4 Kernen laufen zu lassen,
  muss wie folgt kompiliert werden:

  stack ghc --package monad-par -- H11-3.hs -O2 -threaded -with-rtsopts="-N4"

  Um das Programm mit Verwendung von bis zu 8 Kernen laufen zu lassen,
  muss wie folgt kompiliert werden:

  stack ghc --package monad-par -- H11-3.hs -O2 -threaded -with-rtsopts="-N8"

  Natürlich muss ich Rechner über die entsprechende Anzahl Kerne verfügen.
  Die Rechner am CIP-Pool haben in der Regel 4 Kerne.

  Mit 4 Kernen erzielten wir einen passablen Speedup-Faktor von ca. 3 bis 3,3.
-}

import Control.Monad
import Control.Monad.Par
import Data.Maybe (isJust)
import Data.List (sort)
import Data.Char (ord,chr)              -- für verwendete Hilfsfunktionen
import Data.Bits (shift,shiftR,testBit) -- für verwendete Hilfsfunktionen
import Data.Time


main :: IO () -- Berechnung dauert einige Minuten! (Mit ghc kompilieren! Ausführung im Interpreter ghci dauert ewig!)
main = 
  let 
      (e,modulusN) = (65537, 14319953997750485653)
      -- Abgefangene mit öffentlichem Schlüssel kodierte Nachricht:
      cipherText   = [3599095440359684280,8429158900661875260,10178806454520659127,6551064472958297887,5651186809464672658,2111885777557764257,13798324382766252905,6527790781908254521,5242330391010611359,11382816024842545353,844653399386628596,3567901469909441125,2814364451569929674,1877941445914697932,10937769801699527900,7837560062010901347,7031004325217398127,12765689480296485439,9348427278748733404,11906767186059199700,8011393134059371414,5832442572366870044]
      -- kleinstmögliche Primzahl für die Suche
      minp = 3 -- !NICHT VERÄNDERN!
      -- größtmögliche   Primzahl für die Suche
      maxp = sqrtFloor modulusN -- !NICHT VERÄNDERN!


  {-
    *** WICHTIGER HINWEIS ***
    Natürlich könnte man die Berechnung auch beschleunigen,
    in dem man das Such-Intervall verkleinert. Das funktioniert
    auch mit einem festen Beispiel wie hier: wenn man die Lösung p schon kennt,
    sucht man eben nur im Einer-Intervall [p..p].
    Bei der Bewertung werden wir Ihre Abgabe auch mit anderen Schlüsseln testen,
    d.h. lassen Sie das Intervall also unverändert!!!
  -}
  in case parallelFactorisation (minp,maxp) modulusN of
    Nothing  -> putStrLn "Kein Primfaktor gefunden. Entschlüsselung gescheitert!"
    (Just factor) -> do
      let [p,q] = sort [factor, modulusN `div` factor]
      putStrLn $ "Die Faktoren des gegebenen Modulus sind " ++ show p ++ " und " ++ show q ++ "."
      let d = getDecryptionExponent e 3740208377 3828651389
      putStrLn $ "Damit ist der Entschlüsselungsexponent " ++ (show d) ++ "."
      let clearText = decodeLargeText (d,modulusN) cipherText
      putStrLn ("Damit ist der zu entschlüsselnde Klartext:\n  \"" ++ clearText ++ "\".")
{-
      
    do let cipherText   = [10937769801699527900,7837560062010901347,7031004325217398127,12765689480296485439,9348427278748733404,11906767186059199700,8011393134059371414,5832442572366870044]
       let clearText = decodeLargeText (678229659360723969,modulusN) cipherText
       putStrLn ("Damit ist der zu entschlüsselnde Klartext:\n  \"" ++ clearText ++ "\".")
-}

(e,modulusN) = (65537, 14319953997750485653)

--------------------------------------------------
-- Faktorisierung
splitIntervall ::  (Integer,Integer) -> [(Integer,Integer)]
splitIntervall interval@(lo,hi) 
  | lo >= hi = []
  | otherwise = getparts (hi-lo)
    where getparts :: Integer -> [(Integer,Integer)]
          getparts interval =
           [(lo , interval `div` 4),
           ((interval `div` 4)+1 , (interval `div` 4)*2 ),
           (((interval `div` 4)*2)+1 , (interval `div` 4)*3),
           (((interval `div` 4)*3)+1 , hi)]

splitToNIntervals ::  (Integer,Integer) -> Integer -> [(Integer,Integer)]
splitToNIntervals _ 0 = []
splitToNIntervals full 1 = [full]
splitToNIntervals interval@(lo,hi) n 
  | lo >= hi = []
  | otherwise = getparts (hi-lo) n 3 []
    where getparts :: Integer -> Integer -> Integer -> [(Integer,Integer)] -> [(Integer,Integer)]
          getparts interval 0 start acc = (start , hi):acc
          getparts interval n start acc = getparts interval (n-1) ((interval `div` n)+1) ((start , interval `div` n):acc)

{-
           (lo , interval `div` 4):(getparts)

           [,
           ((interval `div` 4)+1 , (interval `div` 4)*2 ),
           (((interval `div` 4)*2)+1 , (interval `div` 4)*3),
           (((interval `div` 4)*3)+1 , hi)]

extractResult :: [IVar (Maybe Integer)] -> IVar (Maybe Integer)
extractResult (a:rest) | (get a) ==  Par Nothing = extractResult rest
                       | otherwise = a 
-}
--hier arbeiten
--runPar $ do { xs <- forM [1..3] (\x -> spawnP (\x -> x*x)); mapM get xs } 
choose :: [(Maybe Integer)] -> Maybe Integer
choose [] = Nothing
choose (Nothing:res) = choose res
choose ((Just a):_) = (Just a)

parallelFactorisation :: (Integer,Integer) -> Integer -> Maybe Integer
parallelFactorisation interval@(lo,hi) p = 
  do runPar $ do let list = splitToNIntervals interval 16
                 res <- mapM (\x -> spawnP $ slowFactor x p) $ splitIntervall interval
                 results <- mapM (\x -> get x) res
                 return $ choose results 
--                 let list = splitIntervall interval
{-
                 x1 <-spawnP $ slowFactor (list!!0)p
                 x2 <-spawnP $ slowFactor (list!!1) p
                 x3 <-spawnP $ slowFactor (list!!2) p
                 x4 <-spawnP $ slowFactor (list!!3) p

                 r1 <- get x1
                 r2 <- get x2
                 r3 <- get x3
                 r4 <- get x4
                 return $ choose [r1, r2, r3, r4]       
-}

--return Nothing
--                list = splitIntervall interval
{- 
        x1 <- spawnP $ slowFactor (list!!0)p
        x2 <-spawnP $ slowFactor (list!!1) p
        x3 <-spawnP $ slowFactor (list!!2) p
        x4 <-spawnP $ slowFactor (list!!3) p
                -}
    --res <- mapM (\x -> spawnP $ slowFactor x p) $ splitIntervall interval
    -- return $ choose $  pmapM (\x -> get x) res
              --singleres <- (\(x:rest) -> )
                 --(_, a) <- waitAny $ res
                --return result
                 -- liftM2 () (get x1) -- $ get x2 -- $ get x3 $ get x4

    --slowFactor interval p
-- intervall (lo,hi) in mehrere Teilintervalle teilen
-- die einzelne Intervalle parllel durchlaufen 
--hier arbeiten

-- Findet den ersten Faktor in einem gegebenen Bereich.
slowFactor :: (Integer,Integer) -> Integer -> Maybe Integer
slowFactor (lo,hi) n
    | lo > hi            = Nothing
    | lo > (sqrtFloor n) = Nothing
    | otherwise = slowFactorRec lo n
  where
    slowFactorRec :: Integer -> Integer -> Maybe Integer
    slowFactorRec curr m
      | mod m curr == 0 = Just curr
      | curr+1 <= hi    = slowFactorRec (curr+1) m
      | otherwise       = Nothing


--------------------------------------------------
-- Kryptographische Funktionen

-- Verschlüsselt mit angegebenem Verschlüsselungsexponenten.
encrypt :: (Integer, Integer) -> [Integer] -> [Integer]
encrypt (e,modulusN) = map (\x -> powModInteger x e modulusN)

-- Entschlüsselt mit berechnetem Entschlüsselungsexponenten.
decrypt :: (Integer, Integer) -> [Integer] -> [Integer]
decrypt (d,modulusN) = map (\x -> powModInteger x d modulusN)

decrypt1 :: (Integer, Integer) -> Integer -> Integer
decrypt1 (d,modulusN) x = powModInteger x d modulusN

getDecryptionExponent :: Integer -> Integer -> Integer -> Integer
getDecryptionExponent e p q = fst $ erwEuklid e $ (p-1)*(q-1)

-- Hier wird angenommen, dass die Characters nur Bytelänge haben...
convertToString :: Integer -> String
convertToString 0 = []
convertToString n
    | n < 0 = error "No negative Integers are allowed!"
    | otherwise = let c = mod n 256
                  in (chr (fromInteger c)) : (convertToString (div (n-c) 256))

-- Hier auch...
convertToInteger :: String -> Integer
convertToInteger = fst . ( foldl (\(g,s) c -> (g + (shift (toInteger $ ord c) (s*8)), s+1) ) (0,0) )

-- Soll verwendet werden, um längere Texte zu kodieren, um sie später zu verschlüsseln.
encodeLargeText :: String -> [Integer] -- eigentlich reicht Int64
encodeLargeText = (map convertToInteger) . (splitItUp 7)

-- Soll verwendet werden, um längere Texte zu dekodieren.
decodeLargeText :: (Integer,Integer) -> [Integer] -> String
decodeLargeText privateKey code =
  -- concatMap (convertToString . (decrypt1 privateKey)) code
  concat $ map convertToString $ decrypt privateKey code


--------------------------------------------------
-- Mathematische Hilfsfunktionen:

{- Hinweis:
  Zur Vereinfachung der Aufgabe liefern wir alle
  benötigten mathematischen Hilfsfunktionen hier mit.
  Die angegebenen Definition sind nicht unbedingt die effizientesten.

  Hier wäre es besser, auf effiziente Bibliotheken zurückzugreifen:
    GHC.Integer.GMP.Internals -- The ​GNU Multiple Precision Arithmetic Library (GMP), in GHC enthalten, benötigt aber unbesprochene Spracherweiterungen.
    Math.NumberTheory         -- arithmoi package, nicht in GHC enthalten, also mit cabal install arithmoi installieren

  Sämtlicher folgender Code funktioniert zwar für diese Aufgabe,
  von einer anderweitigen Verwendung ist aber abzusehen:
-}

sqrtFloor :: Integer -> Integer
sqrtFloor x = floor $ sqrt (fromInteger x) -- RUNDUNGSFEHLER MÖGLICH!
-- Diese Definiton ist problematisch aufgrund der mangelnden Präzision bei der Konvertierung von/nach Double!
-- Für die Aufgabe reicht es, weil der modulus nur 64-Bit ist

-- Schnelles Potentzieren mit Modulo, besser  GHC.Integer.GMP.Internals.powModInteger verwenden, braucht jedoch UnboxedTuples Erweiterung
powModInteger :: Integer -> Integer -> Integer -> Integer
powModInteger base expon modulus = pmAux base expon
  where
    pmAux _ 0     = 1
    pmAux b e
      | even e    =  pmAux (b*b `mod` modulus) (e `div` 2)
      | otherwise = (pmAux (b*b `mod` modulus) (e `div` 2)) * b `mod` modulus

-- Interessanterweise ist die endrekursive Version langsamer,
-- wenn man ghc mit Option "-O2" wildes Optimieren erlaubt:
powModInteger1 :: Integer -> Integer -> Integer -> Integer
powModInteger1 base expon modulus = pmAux base expon 1
  where
    pmAux _ 0 acc = acc
    pmAux b e acc
      | even e    = pmAux (b*b `mod` modulus) (e `div` 2)     acc
      | otherwise = pmAux (b*b `mod` modulus) (e `div` 2)  $! acc * b `mod` modulus

-- erweiterter Euklidischer Algorithmus
erwEuklid :: Integer -> Integer -> (Integer, Integer)
erwEuklid m n
  | 0 == (n `mod` m) = (1,0)
  | otherwise        =
      let (x',y') = erwEuklid (n `mod` m) m
      in  -- trace (show $ ((m,n),(n `div` m),(n `mod` m),(x',y'))) -- trace zur Ausgabe der Zwischenwerte wie bei Papier-Rechnung
          (y'-x'*(n `div` m), x')


----------------------------------------------------------------
-- Allgemeine Hilfsfunktionen:

-- Zerschneidet eine Liste in gleich lange Teillisten.
splitItUp :: Int -> [a] -> [[a]]
splitItUp _ [] = []
splitItUp i l  = (take i l) : (splitItUp i (drop i l))
