freeVars :: Term -> [Char]
freeVars (Var x) = [x]
freeVars (Const _) = []
freeVars (App e1 e2) = (freeVars e1) ++ (freeVars e2)
freeVars (Abs x e1) = filter (/=x) (freeVars e1)