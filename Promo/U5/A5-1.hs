{-# LANGUAGE InstanceSigs #-}

data MyList a = Leer | Element a (MyList a)
 deriving Show


class ToDouble a where
 toDouble :: a -> Double

instance ToDouble (MyList a) where
 toDouble Leer = 0.0
 toDouble (Element a rest) = 1.0 + toDouble rest


--        True && (mylista == mylistb) 


instance (Eq a) => Eq(MyList a) where
  Leer == _ = False
  _ == Leer = False
  (Element a mylista) == (Element b mylistb) = let check1 =  a == b 
                                                   check2 = mylista == mylistb
                                                in  check2 && check1

data Sordde = Erwel 
            | Gummern deriving (Eq, Show)

data Dudde = Dudd{ sort:: Sordde, kilo :: Double, duddepreis :: Double} 
           | Gemischde { kilo :: Double, kilopreis :: Double } deriving Show 

instance Monoid Dudde where
    mempty :: a
    mempty = Gemischde 0 0

    mappend :: a -> a -> a
    mappend d1 d2 = kilo d1 == 0 = kilo d1
                  | kilo d2 == 0 = kilo d2
    mappend (Dudd s1 k1 dp1) (Dudd s1 k1 dp1) = s1 == s2 = Dudd s1 (k1+k2) (dp1+dp2) 
    mappend ( Gemischde k1 kp1 ) ( Gemischde k2 kp2 ) = Gemischde (k1+k2) ((k1*kp1 + k2*kp2) / (k1+k2))