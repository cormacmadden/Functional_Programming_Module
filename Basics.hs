module Basics where

factorial_nop n  =  if n==0 then 1 else n * factorial_nop (n-1)

factorial 0  =  1
factorial n  =  n * factorial (n-1)

mylength []      =  0
mylength (x:xs)  =  1 + mylength xs

myand True True = True
myand _    _    = False
