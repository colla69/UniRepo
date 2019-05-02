

class ToDouble a where 
 toDouble :: a -> Double

data Op = Plus | Minus | Mal | Geteilt
 deriving (Show, Eq)

data RechenBaum = BlattWert Double | AstOp RechenBaum Op RechenBaum
  deriving Show

instance ToDouble RechenBaum where
 toDouble (BlattWert a)    = a 
 toDouble (AstOp b1 Plus b2) = toDouble b1+ toDouble b2
 toDouble (AstOp b1 Minus b2) = toDouble b1 - toDouble b2
 toDouble (AstOp b1 Mal b2) = toDouble b1 * toDouble b2
 toDouble (AstOp b1 Geteilt b2) = toDouble b1 / toDouble b2
 