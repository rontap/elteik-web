module First where
inc n = n +1 

--even' n = n `mod` 2
--odd' n =  1 - (even' n)
even' n = not (odd' n)
odd' 1 = False
odd' n = not (even' n)
