
{-# LANGUAGE InstanceSigs #-}

module H63 where 

data MyList a = Leer | Element a (MyList a) deriving Show

instance Monoid (MyList a) where
  mempty :: (MyList a)
  mempty = Leer

  mappend :: (MyList a) -> (MyList a) -> (MyList a)
  mappend Leer Leer = Leer
  mappend a Leer = a
  mappend Leer b = b
  mappend (Element b mybList) a = (Element b (mappend mybList a))

  mconcat :: [(MyList a)] -> MyList a
  mconcat a = foldl (mappend) mempty a

testmonoid :: IO ()
testmonoid = do

  putStrLn( "  " )
  putStrLn( "Monoid test" )
  let alist = (Element 1(Element 2 Leer))
      blist = (Element 3(Element 4 (Element 5 Leer)))
      clist = (Element 6(Element 7 (Element 8 (Element 9 Leer))))
      slist = [(Element 1 Leer), (Element 2 Leer), (Element 3 Leer)]
  putStrLn( "  " )
  putStrLn( "alist: "++show( alist ))
  putStrLn( "blist: "++show( blist ))
  putStrLn( "clist: "++show( clist ))
  putStrLn( "slist: "++show( slist ))


  putStrLn( "  " )
  putStrLn( " putStrLn( show( mappend alist blist )) " )
  putStrLn( show( mappend alist blist ))

  putStrLn( "  " )
  putStrLn( " putStrLn( show( mappend alist blist )) " )
  putStrLn( show( mappend alist blist ))

  putStrLn( "  " )
  putStrLn( " putStrLn( show( mappend alist clist )) " )
  putStrLn( show( mappend alist clist ))

  putStrLn( "  " )
  putStrLn( " putStrLn( show( mappend alist Leer )) " )
  putStrLn( show( mappend alist Leer ))

  putStrLn( "  " )
  putStrLn( " putStrLn( show( mconcat slist )) " )
  putStrLn( show( mconcat slist ))
