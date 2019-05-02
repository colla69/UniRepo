-- Code aus Vorlesung "Programmierung und Modellierung", Sommersemester 2018
-- Steffen Jost, LMU München

-- Analogie: IO als Zustandsmonade

import Prelude hiding (IO)

data Welt = Welt { zeit :: Int, wetter :: String }
  deriving Show
type IO a = Welt -> (a,Welt)

komposition :: IO a -> ( a -> IO b) -> IO b
-- komposition ::
--   (Welt -> (a,Welt))
--   -> ( a -> Welt -> (b,Welt))
--   -> Welt
--   -> (b, Welt)
komposition ersteAkt zweitAkt welt1 =
  let (xa,welt2) = ersteAkt welt1
      (yb,welt3) = zweitAkt xa welt2
  in (yb,welt3)

nacheinander :: IO a -> IO b -> IO b
nacheinander ersteAkt zweitAkt = ersteAkt `komposition` (\_ -> zweitAkt)

tick :: IO Int
-- tick :: Welt -> (Int,Welt)
tick welt = (zeit welt, welt { zeit = 1 + zeit welt} )

sonne :: IO ()
sonne welt = ( (), welt { wetter = "sonnig" } )

machWetter :: String -> IO ()
machWetter w welt = ( (), welt { wetter = w } )

test :: String -> IO String
test s welt = 
	tick "meinemutter"
	tick "meinemutter"
	tick "meinemutter"