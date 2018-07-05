module Warteschlange (einstellen, abholen, leer) where

import qualified Data.Map as Map

data List a = El [a] deriving Show
type Warteschlange a = (List a,List a)

leer :: Warteschlange a
leer = (El [],El [])

einstellen :: a -> Warteschlange a -> Warteschlange a
einstellen a (El [],El b) = ((El [a]), (El b))
einstellen a (El b,El c) = ((El (a:b)), (El c))


abholen :: Warteschlange a -> (Maybe a, Warteschlange a)
abholen (El []      ,El [])       = (Nothing, Warteschlange.leer)
abholen (El []      ,El (b:rest)) = (Just b, (El [],El (rest)))
abholen (El (a),El [])       = abholen (El [],El (reverse a))
abholen (El a       ,El b)        = abholen (El [],El (b++(reverse a))) 
                                      
-- TEST
it = einstellen 'c' (einstellen 'b' (einstellen 'a' leer))
