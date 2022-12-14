module Ex01 where
import Data.Char (toUpper)

name, idno, username :: String
name      =  "Cormac Madden"  -- replace with your name
idno      =  "18319983"    -- replace with your student id
username  =  "maddenc6"   -- replace with your TCD username


declaration -- do not modify this
 = unlines
     [ ""
     , "@@@ This exercise is all my own work."
     , "@@@ Signed: " ++ name
     , "@@@ "++idno ++ " "++username
     ]


{- Part 1

Write a function 'raise' that converts a string to uppercase

Hint: 'toUpper :: Char -> Char' converts a character to uppercase
if it is lowercase. All other characters are unchanged.
It is imported should you want to use it.

-}
raise :: String -> String
raise = map toUpper
{- Part 2

Write a function 'nth' that returns the nth element of a list.
Hint: the test will answer your Qs

-}
nth :: Int -> [a] -> a
nth x xs = (!!) xs (x-1)

{- Part 3

Write a function `commonLen` that compares two sequences
and reports the length of the prefix they have in common.

-}
commonLen :: Eq a => [a] -> [a] -> Int
commonLen [] [] = 0
commonLen [] _ = 0
commonLen _ [] =0
commonLen xs ys = length( highestPre xs ys )


highestPre :: Eq a => [a] -> [a] -> [a]
highestPre [] [] = [] 
highestPre [] _ = []
highestPre _ [] = []
highestPre xs ys
              | head(xs) == head(ys) = head(ys) : highestPre (tail xs) (tail ys)
              | otherwise = []
{- Part 4

(TRICKY!) (VERY!)

Write a function `runs` that converts a list of things
into a list of sublists, each containing elements of the same value,
which when concatenated together give the same list

So `runs [1,2,2,1,3,3,3,2,2,1,1,4]`
 becomes `[[1],[2,2],[1],[3,3,3],[2,2],[1,1],[4]]`

Hint:  `elem :: Eq a => a -> [a] -> Bool`

HINT: Don't worry about code efficiency
       Seriously, don't!

-}


runs :: Eq a => [a] -> [[a]]
runs xs = undefined
{--
-- runs [] = [[0]] 
runs xs = sublist(xs) : []
-- runs : f xs
 --      | head(xs) == head(tail(xs)) = 

sublist :: Eq a => [a] -> [a]
--}
{--sublist xs
       | head(xs) == head(tail xs) = head(xs) : sublist(tail xs)
       | head(xs) != head(tail xs) = 
       | otherwise = []

--test :: Int a => [a]
--test = [42,42]

splitAt :: Int -> [a] -> ([a],[a])
splitAt 0 xs = ([], xs)
splitAt n [] = ([],[])
splitAt n (x:xs) =
   let (rfst, rsnd) = splitAt (n-1) xs
   in (x:rfst, rsnd)
--}
