--import Control.Monad.Trans.State
import Control.Monad
import Control.Monad.Par
{-
f :: State Int ()
f = do
    r <- g
    modify (+ r)

g :: State Int Int
g = do
    modify (+ 1)
    get
-}
main = do
 a <- runPar $ do { xs <- forM [1..3] (\x -> spawnP (\x -> x*x)); mapM get xs }
 putStrLn $ show $ a
 --putStrLn $ show $ forM [1..3] (\x -> if even x then Just x else Nothing)

