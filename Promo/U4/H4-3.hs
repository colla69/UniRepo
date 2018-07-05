

data MyList a = Leer | Element a (MyList a)
 deriving Show 


verketten :: MyList a -> MyList a -> MyList a
verketten Leer Leer                     = Leer
verketten Leer  (Element e(myList))        = (Element e( myList ))
verketten (Element e(myList)) Leer         = (Element e( myList ))
verketten (Element e(myList)) (Element f(myList2)) = (Element e (verketten myList (Element f(myList2))))
