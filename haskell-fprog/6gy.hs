isValid:: [Char] -> Bool
isValid ('M':'A':':':_) = True
isValid ('S':'M':':':_) = True
isValid ('T':'A':':':_) = True
isValid _ = False

firstTwo:: [Bool] -> Bool
firstTwo (True:False:_) = True
firstTwo (False:True:_) = True 
firstTwo (True:[]) = True 
firstTwo _ = False

