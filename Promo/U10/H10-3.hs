{-  Übung H10-3 zur Vorlesung "Programmierung und Modellierung"
    Lehrstuhl für theoretische Informatik, LMU München
    Steffen Jost, Leah Neukirchen

    Bitte nur die Zeilen mit
      error "TODO" -- TODO: Ihre Aufgabe !!!
    bearbeiten.
    (Sie dürfen an diesen Stellen auch beliebig
    viele neue Zeilen einfügen.)

    Entweder mit ghc kompilieren und ausführen oder
    einfach in ghci laden und main auswerten.
-}
{-# LANGUAGE InstanceSigs #-}

import Prelude
import Control.Monad.Trans.State

type Wetter = String
data Welt = Welt { zeit :: Int, wetter :: Wetter }
  deriving Show

main =
  let startState = Welt { zeit=0, wetter="Regen" }
      (result,finalState) = runState actions startState
  in do
    putStrLn "Zustand Welt bei Start ist: "
    print startState
    putStrLn "Zustand Welt bei Ende ist: "
    print finalState
    putStrLn "Ergebnis der Aktion ist: "
    print result


actions :: State Welt [(String,Int)]
actions = do
  tick
  tick
  tick
  tick
  wetter1 <- swapWetter "Sonne"
  zeit1 <- gets zeit
  let r1 = (wetter1, zeit1)
  tick
  tick
  wetter2 <- swapWetter "Sturm"
  zeit2 <- zeit <$> get
  let r2 = (wetter2, zeit2)
  tick
  return [r1,r2]


--- !!! NUR AB HIER BEARBEITEN !!!

tick :: State Welt ()
tick = do
      modify(\(Welt z w) -> (Welt z w) {zeit=(z+1), wetter=w })

      --  \w1 -> (wetter w1, w1 {wetter=wetterneu})
  --State $ \(Welt z w) -> Welt [("",1)] 
  --error "TODO: tick noch nicht implementiert!" -- TODO: Ihre Aufgabe !!!

swapWetter :: Wetter -> State Welt Wetter
swapWetter nw = do
      modify(\(Welt z w) -> (Welt z w) { wetter=nw })
      s <- get
      return $ wetter s
  --Welt $ \w -> (wetter w , w {wetter=nw})
  --error "TODO: swapWetter noch nicht implementiert!" -- TODO: Ihre Aufgabe !!!



















