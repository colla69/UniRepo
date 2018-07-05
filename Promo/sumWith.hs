{-  Vorlesung "Programmierung und Modellierung"
    Sommersemester 2018, LMU München
    Steffen Jost

Demonstration Stack-Überlauf wegen Lazy Evaluation

Vergleiche:
  > ghc sumWith -O2 -fforce-recomp
  ./sumWith
mit   
  > ghc sumWith -O0 -fforce-recomp
  ./sumWith

Ohne die Striktheits-Analyse des Kompilers ist sumWith (lazy-Variante) deutlich langsamer und Speicherplatz intensiver.

Verwendete Optionen:
  -O2                   Alle Optimierungen einschalten
  -O0                   Alle Optimierungen ausschalten
  -fforce-recomp        Komplette Kompilation des Programm erzwingen
  
Informationen zum Speicherverbrauch einsehbar z.B. mit: 
  > ghc sumWith.hs -O2 -fforce-recomp -rtsopts
  > ./sumWith +RTS -s

Genaueres Profiling mit:
  > ghc sumWith.hs -O2 -fforce-recomp -rtsopts -prof -fprof-auto  
  > ./sumWith +RTS -p
  generiert sumWith.prof mit Profiling Information

Speicherverbrauch einschränkbar mit RTSOPTS:
  Stack: -K100m  (100 Megabyte)
  Heap:  -M2g    (  2 Gigabyte)
  > ghc sumWith -O0 -fforce-recomp -rtsopts
  > ./sumWith +RTS -M2G -K100m
  Nur Lazy-Version scheitert an verfügbarem Stack (bei ausgeschalteten Optimierungen)
-}    
  
  
import Data.Time

sumWithLazy :: [Int] -> Int -> Int
sumWithLazy   []  acc = acc
sumWithLazy (h:t) acc = sumWithLazy t $ acc+h

sumWithStrict ::  [Int] -> Int -> Int
sumWithStrict   []  acc = acc
sumWithStrict (h:t) acc = sumWithStrict t $! acc+h

listsize :: Int
listsize = 12399999   -- Wert an Hardware anpassen!

main :: IO ()
main = do
        t <- printLocalTime
        putStrLn "Reducing List"      -- Liste auswerten, damit Messung fair ist!
        let list = [1..listsize] ++ [listsize,listsize-1..1]
        seq (map seq list) $ print $ last list
        t <- printTimeDiff t
        putStrLn "Computing strict sum"
        let sum2 = sumWithStrict list 0
        print sum2
        t <- printTimeDiff t        
        putStrLn "Computing lazy sum"
        let sum1 = sumWithLazy list 0
        print sum1
        t <- printTimeDiff t
        return ()        
        
printTimeDiff :: UTCTime -> IO UTCTime -- Nicht sehr akkurat, aber hier gut genug.
printTimeDiff t1 = do
  putStr "Time elapsed: "
  t2 <- getCurrentTime
  print $ diffUTCTime t2 t1
  return t2

printLocalTime :: IO UTCTime
printLocalTime = do
  putStr "Time is: "
  time <- getZonedTime  
  print time
  return $ zonedTimeToUTC time
  
