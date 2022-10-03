module Practice where
import Data.Char

main :: IO ()
main = do 
    putStr "EnterFile <root.ext>: " 
    response <- getLine --getLine :: IO String
    putStrLn ("Reading " ++ response)
    contents <- readFile response
    putStrLn ("Contents\n" ++ contents)
    let lowered = map toLower contents
    putStrLn ("Lowered\n" ++ lowered)
    let root = getFileRoot response
    writeFile (root++".log") lowered

getFileRoot :: String -> String
getFileRoot "" = ""
getFileRoot (c:cs)
    | c == '.' = ""
    | otherwise = c : getFileRoot cs

data Tree = Empty
            | Single Int String
            | Many Tree Int String Tree

search :: Int -> Tree -> String

search x (Single i s)
 | x == i       = s
search x (Many left i s right)
 | x == i       = s
 | x > i        = search x right
 | x < i        = search x right

