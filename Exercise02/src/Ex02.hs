{- butrfeld Andrew Butterfield -}
module Ex02 where
import Data.List ((\\))

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

-- Datatypes and key functions -----------------------------------------------

-- do not change anything in this section !

type Id = String

data Expr
  = Val Double
  | Add Expr Expr
  | Mul Expr Expr
  | Sub Expr Expr
  | Dvd Expr Expr
  | Var Id
  | Def Id Expr Expr
  deriving (Eq, Show)

type Dict k d  =  [(k,d)]

define :: Dict k d -> k -> d -> Dict k d
define d s v = (s,v):d

find :: Dict String d -> String -> Either String d
find []             name              =  Left ("undefined var "++name)
find ( (s,v) : ds ) name | name == s  =  Right v
                         | otherwise  =  find ds name

type EDict = Dict String Double

v42 = Val 42 ; j42 = Just v42

-- do not change anything above !

-- Part 1 : Evaluating Expressions -- (50 test marks, worth 25 Exercise Marks) -

-- Implement the following function so all 'eval' tests pass.

-- eval should return `Left msg` if:
  -- (1) a divide by zero operation was going to be performed;
  -- (2) the expression contains a variable not in the dictionary.
  -- see test outcomes for the precise format of those messages

-- Part 1 : Expression Laws -- (15 test marks, worth 15 Exercise Marks) --------

eval :: EDict -> Expr -> Either String Double
--Base Cases
eval _ (Val x) = Right x 
eval _ (Add (Val x) (Val y)) = Right (x + y)
eval _ (Sub (Val x) (Val y)) = Right (x - y)
eval _ (Mul (Val x) (Val y)) = Right (x * y)
eval _ (Dvd _ (Val 0.0)) = Left "div by zero"
eval _ (Dvd (Val x) (Val y)) = Right (x / y)

eval [] (Add (Val _) (Var y)) = find [] y
eval [] (Add (Var x) (Val _)) = find [] x

eval [] (Sub (Val _) (Var y)) = find [] y
eval [] (Sub (Var x) (Val _)) = find [] x

eval [] (Mul (Val _) (Var y)) = find [] y
eval [] (Mul (Var x) (Val _)) = find [] x

eval [] (Dvd (Val _) (Var y)) = find [] y
eval [] (Dvd (Var x) (Val _)) = find [] x

eval [] (Var x) = find [] x
eval d (Var x) = find d x


eval d (Def x (Val y) e2) = eval (define d x y) e2
eval _ (Def _ _ _) = Left "div by zero"

--Converting Variables int the dictionary to Values to compute
eval ((k,v):ds) (Add (Var x) (Val y)) | x == k = eval [("converted",0.0)] (Add (Val v) (Val y))
                                      | otherwise = eval ds (Add (Var x) (Val y))

eval ((k,v):ds) (Add (Val x) (Var y)) | y == k = eval [("converted",0.0)] (Add (Val x) (Val v))
                                      | otherwise = eval ds (Add (Val x) (Var y))

eval ((k,v):ds) (Add (Var x) (Var y)) | x == k = eval ds (Add (Val v) (Var y)) -- here
                                      | y == k = eval ds (Add (Var x) (Val v))
                                      | otherwise = eval ds (Add (Var x) (Var y))

eval _ (Add _ _) = Left "div by zero"


eval ((k,v):ds) (Sub (Var x) (Val y)) | x == k = eval [("converted",0.0)] (Sub (Val v) (Val y))
                                      | otherwise = eval ds (Sub (Var x) (Val y))

eval ((k,v):ds) (Sub (Val x) (Var y)) | y == k = eval [("converted",0.0)] (Sub (Val x) (Val v))
                                      | otherwise = eval ds (Sub (Val x) (Var y))

eval ((k,v):ds) (Sub (Var x) (Var y)) | x == k = eval ds (Sub (Val v) (Var y))
                                      | y == k = eval ds (Sub (Var x) (Val v))
                                      | otherwise = eval ds (Sub (Var x) (Var y))

eval _ (Sub _ _) = Left "div by zero"



eval ((k,v):ds) (Mul (Var x) (Val y)) | x == k = eval [("converted",0.0)] (Mul (Val v) (Val y))
                                      | otherwise = eval ds (Mul (Var x) (Val y))

eval ((k,v):ds) (Mul (Val x) (Var y)) | y == k = eval [("converted",0.0)] (Mul (Val x) (Val v))
                                      | otherwise = eval ds (Mul (Val x) (Var y))

eval ((k,v):ds) (Mul (Var x) (Var y)) | x == k = eval ds (Mul (Val v) (Var y))
                                      | y == k = eval ds (Mul (Var x) (Val v))
                                      | otherwise = eval ds (Mul (Var x) (Var y))

eval _ (Mul _ _) = Left "div by zero"


eval ((k,v):ds) (Dvd (Var x) (Val y)) | x == k = eval [("converted",0.0)] (Dvd (Val v) (Val y))
                                      | otherwise = eval ds (Dvd (Var x) (Val y))

eval ((k,v):ds) (Dvd (Val x) (Var y)) | y == k = eval [("converted",0.0)] (Dvd (Val x) (Val v))
                                      | otherwise = eval ds (Dvd (Val x) (Var y))

eval ((k,v):ds) (Dvd (Var x) (Var y)) | x == k = eval ds (Dvd (Val v) (Var y))
                                      | y == k = eval ds (Dvd (Var x) (Val v))
                                      | otherwise = eval ds (Dvd (Var x) (Var y))

eval _ (Dvd _ _) = Left "div by zero"

{-

There are many, many laws of algebra that apply to our expressions, e.g.,

  x + y            =  y + x         Law 1
  x + (y + z)      =  (x + y) + z   Law 2
  x - (y + z)      =  (x - y) - z   Law 3
  (x + y)*(x - y)  =  x*x - y*y     Law 4
  ...

  We can implement these directly in Haskell using Expr

  Function LawN takes an expression:
    If it matches the "shape" of the law lefthand-side,
    it replaces it with the corresponding righthand "shape".
    If it does not match, it returns Nothing

    Implement Laws 1 through 4 above
-}


law1 :: Expr -> Maybe Expr
law1 (Add x y) = Just (Add y x)
law1 _ = Nothing

law2 :: Expr -> Maybe Expr
law2 (Add x (Add y z)) = Just (Add (Add x y) z)
law2 _ = Nothing

law3 :: Expr -> Maybe Expr
law3 (Sub x (Add y z)) = Just (Sub (Sub x y) z)
law3 _ = Nothing

law4 :: Expr -> Maybe Expr
law4 (Mul (Add x y) (Sub a b)) = 
                                if x == a && y == b
                                  then Just (Sub (Mul x x) (Mul y y))
                                  else Nothing
law4 _ = Nothing