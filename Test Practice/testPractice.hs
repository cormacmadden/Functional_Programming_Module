import System.IO
-- import Data.List

main :: IO ()
main = do putStrLn "What's your name: "
--    name <- getLine
--	putStrLn ("Hello " ++ name)

head ::  [a] -> a
head (x:_) = x
head [] = putStrLn "errorEmptyList"

--badHead :: a
--badHead = putStrLn "errorEmptyList"

