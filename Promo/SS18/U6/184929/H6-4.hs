{-# LANGUAGE InstanceSigs #-}

module Ubungen.H64 where

data Einige a = Keins | Eins a | Zwei a a | Drei a a a
  deriving (Eq, Ord, Show)


instance Functor Einige where

  fmap :: (a -> b) -> (Einige a) -> (Einige b)
  fmap _ Keins = Keins
  fmap f (Eins a) = (Eins (f a))
  fmap f (Zwei a b) = (Zwei (f a) (f b))
  fmap f (Drei a b c) = (Drei (f a) (f b) (f c))


 --test
 
testfunctor :: IO ()
testfunctor = do 
  putStrLn( "  " )
  putStrLn( "Functor Einige  test" )
  let e0 = Ubungen.H64.Keins
      e1 = (Eins 1)
      e2 = (Zwei 1 2)
      e3 = (Drei 1 2 3)
  putStrLn( "e0 Keins" )
  putStrLn( "e1 "++show( e1) )
  putStrLn( "e2 "++show( e2) )
  putStrLn( "e3 "++show( e3) )

  putStrLn( "" )
  putStrLn( "fmap (\\x -> x+1) e1 " )
  putStrLn( show(fmap (\x -> x+1) e1) )
  
  putStrLn( "" )
  putStrLn( "fmap (\\x -> x*x) e2" )
  putStrLn( show(fmap (\x -> x*x) e2) )

  putStrLn( "" )
  putStrLn( "fmap sqrt e3" )
  putStrLn( show(fmap sqrt e3) )

  putStrLn( "" )
  putStrLn( "even <$> e2 " )
  putStrLn( show( even <$> e2)  ) 
  
