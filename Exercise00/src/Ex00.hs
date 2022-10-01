module Ex00 where

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

{- Modify everything below here as you see fit to ensure all tests pass -}

hello  =  "Hello World :-)"
