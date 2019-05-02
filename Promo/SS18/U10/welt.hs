{-# LANGUAGE InstanceSigs #-}
-- Code aus Vorlesung "Programmierung und Modellierung", Sommersemester 2018
-- Steffen Jost, LMU München

-- Analogie: MyIO als Zustandsmonade

import Prelude

data Welt = Welt { zeit :: Int, wetter :: String }
  deriving Show

type MyIO a = Welt -> (a,Welt)

komposition :: MyIO a -> ( a -> MyIO b) -> MyIO b
-- komposition ::
--   (Welt -> (a,Welt))
--   -> ( a -> Welt -> (b,Welt))
--   -> Welt
--   -> (b, Welt)
komposition ersteAkt zweitAkt welt1 =
--   let (xa,welt2) = ersteAkt welt1
--       (yb,welt3) = zweitAkt xa welt2
--   in (yb,welt3)
  let (xa,welt2) = ersteAkt welt1
  in zweitAkt xa welt2

nacheinander :: MyIO a -> MyIO b -> MyIO b
nacheinander ersteAkt zweitAkt = ersteAkt `komposition` (\_ -> zweitAkt)

tick :: MyIO Int
-- tick :: Welt -> (Int,Welt)
tick welt = (zeit welt, welt { zeit = 1 + zeit welt} )

tauscheWetter :: String -> MyIO String
tauscheWetter s welt = ( wetter welt  , welt { wetter = s } )

sonne :: MyIO ()
sonne welt = ( (), welt { wetter = "sonnig" } )

machWetter :: String -> MyIO ()
machWetter w welt = ( (), welt { wetter = w } )

-- Test
startWelt :: Welt
startWelt = Welt { wetter="kalt", zeit=0 }

test1 :: MyIO String
test1 =
  tick  `nacheinander`
  tick  `nacheinander`
  sonne `nacheinander`
  tick  `nacheinander`
  tauscheWetter "regen" `komposition`
  tauscheWetter

newtype Zustand a = Zu (Welt -> (a,Welt))

noZu :: Zustand a -> (Welt -> (a,Welt))
noZu (Zu act) = act

instance Monad Zustand where
  return :: a -> Zustand a -- Zu (Welt -> (a,Welt))
  return x = Zu $ \w -> (x,w)

  act1 >>= act2 = Zu $ \w1 ->
                    let (a, w2) = noZu act1 w1
                    in noZu (act2 a) w2
{-
instance Functor Zustand where
  fmap f mx = mx >>= (\x -> return $ f x)
-}
instance Functor Zustand where
  fmap f mx = -- f  ::   a -> b
              -- mx :: Zustand a
              -- <ergebnis> :: Zustand b
              Zu $ \w1 ->
                  let (xa,w2) = noZu mx w1
                  in (f xa,w2)
{-
instance Applicative Zustand where
  pure = return
  mf <*> mx = mf >>= (\f -> mx >>= (\x -> return $ f x) )
-}
instance Applicative Zustand where
  pure x = Zu $ \w -> (x,w)
  mf <*> mx = Zu $ \w1 ->
              let (f,w2) = noZu mf w1
                  (x,w3) = noZu mx w2
              in (f x, w3)


swapWetter :: String -> Zustand String
swapWetter wetterneu = Zu $ \w1 -> (wetter w1, w1 {wetter=wetterneu})

swapInt :: Int -> Zustand Int
swapInt i = Zu $ \(Welt z w) -> (z, Welt i w)

incInt :: Zustand ()
incInt = do
  i <- swapInt 0
  swapInt $ i+1
  return ()

testNeu :: Zustand ()
testNeu = do
  incInt
  incInt
  incInt
  incInt
  x <- swapInt 999
  let xshown = "Zeit war: " ++ show x
  altWetter <- swapWetter xshown
  incInt


runTest :: ((), Welt)
runTest = noZu testNeu (Welt 0 "regen")


