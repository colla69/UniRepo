{-
  Übung 9 zu Programmierung und Modellierung Sommersemester 2018
  Lehrstuhl TCS der LMU München
  Steffen Jost, Leah Neukirchen

  Achtung: Die Lösung zur vorangegangenen Hausaufgabe H8-1
  wir hier benötigt. Sie können Ihre eigene Lösung oder
  die Musterlösung verwenden (sobald diese herausgegeben wurde).

-}



data Term = Var Char | Const Int 
          | App Term Term | Abs Char Term  
  deriving (Eq, Show)


-- Ein paar bekannte Terme aus der Literatur zum Lambda-Kalkül,
-- welche sich zum Testen eignen:

-- Combinators
cI      = Abs 'x' $ Var 'x'                            -- \x  ->x
cK      = Abs 'x' $ Abs 'y' $ Var 'x'                  -- \x y-> x
cS      = Abs 'z' $ Abs 'y' $ Abs 'x' $ App (App (Var 'z') (Var 'x')) (App (Var 'y') (Var 'x'))
cT      = Abs 'x' $ App (Var 'x') (Var 'x')
cOmega  = App cT cT
-- Church Booleans
cTRUE   = Abs 'x' $ Abs 'y' $ Var 'x'                  -- \x y-> x
cFALSE  = Abs 'x' $ Abs 'y' $ Var 'y'                  -- \x y-> y
cCOND   = Abs 'x' $ Abs 'y' $ Abs 'z' $ App (App (Var 'x') (Var 'y')) (Var 'z')
-- Church Numerals
c0      = Abs 'f' $ Abs 'x' $ Var 'x'                  -- \f x-> x
c1      = Abs 'f' $ Abs 'x' $ App (Var 'f') (Var 'x')  -- \f x-> f x
cSUCC   = Abs 'n' $ Abs 'f' $ Abs 'x' $ App (Var 'f') $ App (App (Var 'n' ) (Var 'f')) (Var 'x')
cPLUS   = Abs 'm' $ Abs 'n' $ Abs 'f' $ Abs 'x' $ App (App (Var 'm') (Var 'f')) $ App (App (Var 'n' ) (Var 'f')) (Var 'x')
cISNULL = Abs 'x' $ App (App (Var 'x') (Abs 'x' cFALSE)) cTRUE

freeVars :: Term -> [Char]
freeVars = error "Lösung von H8-1a ist hier noch einzufügen!"

genFreshV :: [Char] -> Char
genFreshV vs = head $ filter (\c -> not $ c `elem` vs) ['a'..'z']

subst :: (Char, Term) -> Term -> Term
subst = error "Lösung von H8-1b ist hier noch einzufügen!"

-- TODO: IHRE AUFGABE !!!
eval :: Term -> Term
eval = error "Lösung von H9-3 ist hier zu schreiben!"

