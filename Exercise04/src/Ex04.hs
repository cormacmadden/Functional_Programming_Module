{- butrfeld Andrew Butterfield -}
module Ex04 where

name, idno, username :: String
name      =  "Cormac Madden"  -- replace with your name
idno      =  "18319983"    -- replace with your student id
username  =  "maddenc6"   -- replace with your TCD username

declaration -- do not modify this
 = unlines
     [ ""
     , "@@@ This exercise is all my own work."
     , "@@@ Signed: " ++ name
     , "@@@ "++idno++" "++username
     ]

-- Datatypes -------------------------------------------------------------------

-- do not change anything in this section !


-- a binary tree datatype, honestly!
data BinTree k d
  = Branch (BinTree k d) (BinTree k d) k d
  | Leaf k d
  | Empty
  deriving (Eq, Show)

-- Part 1 : Tree Insert -------------------------------

-- Implement:

ins :: Ord k => k -> d -> BinTree k d -> BinTree k d
ins a b Empty = Leaf a b
ins a b (Leaf c d) | a < c                  = Branch (Leaf a b) Empty c d
ins a b (Leaf c d) | a > c                  = Branch Empty (Leaf a b) c d
ins a b (Leaf c d) | a == c                 = Leaf c b

ins a b (Branch l r x y)
          | a < x =   Branch (ins a b l) r x y
          | a > x =   Branch l (ins a b r) x y
          | a == x =  Branch l r x b

-- Part 2 : Tree Lookup -------------------------------

-- Implement:
lkp :: (Monad m, Ord k) => BinTree k d -> k -> m d
lkp Empty _ = maybeToMonad Nothing
lkp (Leaf k d) key 
  | key == k = maybeToMonad (Just d)
  | key /= k = maybeToMonad Nothing
lkp (Branch l r k d) key
  | key < k   = lkp l key
  | key > k   = lkp r key
  | key == k  = maybeToMonad (Just d)

maybeToMonad :: Monad m => Maybe a -> m a
maybeToMonad maybeA = 
    case maybeA of
        Nothing -> fail "didn't happen"
        Just a  -> return a

-- Part 3 : Tail-Recursive Statistics

{-
   It is possible to compute BOTH average and standard deviation
   in one pass along a list of data items by summing both the data
   and the square of the data.
-}
twobirdsonestone :: Double -> Double -> Int -> (Double, Double)
twobirdsonestone listsum sumofsquares len
 = (average,sqrt variance)
 where
   nd = fromInteger $ toInteger len
   average = listsum / nd
   variance = sumofsquares / nd - average * average

{-
  The following function takes a list of numbers  (Double)
  and returns a triple containing
   the length of the list (Int)
   the sum of the numbers (Double)
   the sum of the squares of the numbers (Double)

   You will need to update the definitions of init1, init2 and init3 here.
-}
getLengthAndSums :: [Double] -> (Int,Double,Double)
getLengthAndSums ds = getLASs init1 init2 init3 ds
init1 = 0
init2 = 0.0
init3 = 0.0
{-
  Implement the following tail-recursive  helper function
-}
getLASs :: Int -> Double -> Double -> [Double] -> (Int,Double,Double)
getLASs a b c [] = (a,b,c)
getLASs a b c (x:xs) = getLASs (a+1) (b+x) (c+(x*x)) xs

-- Final Hint: how would you use a while loop to do this?
--   (assuming that the [Double] was an array of double)
