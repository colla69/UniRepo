-- TEST TOOLS
count :: [Bool] -> Int
count [] = 0
count (x:rest) = return 
    where return = if x==True then 1+(count rest) else 0+(count rest)

test :: [Bool]
test = (erfolg(1,2,3) 5 (1,2,3)):[]

myDiv :: Int -> Int -> Double -- Typsignatur verhindert Fehlermeldung!
myDiv z n = (fromIntegral z) / (fromIntegral n)
--------------------------------------------------------------------------
-- 2 oder 3 * 1 = True 
-- 2 or 3 mal 20 = false
---  summe aller [ wurf - fertigKeitsNo ] > 0  muss gösser N sein
erfolg :: (Int,Int,Int) -> Int -> (Int,Int,Int) -> Bool
erfolg    (_,_,_)          _      (1,_,1)       = True
erfolg    (_,_,_)          _      (1,1,_)       = True
erfolg    (_,_,_)          _      (_,1,1)       = True
erfolg    (_,_,_)          _      (20,_,20)     = False
erfolg    (_,_,_)          _      (20,20,_)     = False
erfolg    (_,_,_)          _      (_,20,20)     = False
erfolg    (ax,ay,az)       n      (bx,by,bz)    = y-n<=0 
   where z = if bx-ax>=0 then bx-ax else 0
         x = if by-ay>=0 then z+by-ay else z 
         y = if bz-az>=0 then x+bz-az else x 

wurfMenge :: [(Int,Int,Int)]
wurfMenge = [(a,b,c) | a<-[1..20], b<-[1..20],c<-[1..20]]

ergebnissCalculator :: (Int,Int,Int) -> [(Int,Int,Int)] -> Int-> [Bool]
ergebnissCalculator _ _  0 = []
ergebnissCalculator _ [] _ = []
ergebnissCalculator (x,y,z) (h:rest) n = 
    (erfolg (x,y,z) n h):( ergebnissCalculator (x,y,z) rest n )

chance :: (Int,Int,Int) -> Int -> Double
chance (x,y,z) n = 
    return where return :: Double
                 possibilities :: [Bool]
                 possibilities = ergebnissCalculator (x,y,z) wurfMenge n
                 c :: Int
                 c = count possibilities 
                 return = c `myDiv` (length wurfMenge)
