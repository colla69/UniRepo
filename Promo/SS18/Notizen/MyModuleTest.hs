

module MyModule where

a :: String
a = "Fuck you"

b :: String
b = "Fuck you too :)"


concatThatShit :: [a] -> [a] -> [a]
concatThatShit a [] = a
concatThatShit [] b = b
concatThatShit a b = a ++ b
