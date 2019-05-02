


data Term = Var Char | Const Int | App Term Term | Abs Char Term

instance Show Term where
  show a = freeVars a

genFreshV :: [Char] -> Char
genFreshV vs = head $ filter (\c -> not $ c `elem` vs) ['a'..'z']

freeVars :: Term -> [Char]
freeVars (Var a) = [a]
freeVars (Const a) = show a
freeVars (App a b) = freeVars a ++ freeVars b
freeVars (Abs a b) = [a] ++ freeVars b

-- subst :: (Char, Term) -> Term -> Term . subst ('x', t1) t2


subst :: (Char, Term) -> Term -> Term
subst (a , t1) t2 = 




--test
t1 = (App (Abs 'a' (Var 'n'))(App (App (Var 'd') (Var 'r')) (App (Var 'e') (Var 'a') )))
test1 = putStrLn $ freeVars t1
t2 = (App (Abs 'a' (Const 1))(App (App (Const 2) (Var 'r')) (App (Var 'e') (Var 'a') )))
test2 = putStrLn $ freeVars t2
