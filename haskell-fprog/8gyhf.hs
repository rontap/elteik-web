deliveryCostReducer :: [(string,Integer,Integer)] -> Integer -> Integer
deliveryCostReducer [] sumPrice
 | sumPrice >= 30000 = 5000
 | otherwise = 10000

deliveryCostReducer ((name,weight,price):xs) sumPrice
 | weight >= 50 = 0
 | otherwise = deliveryCostReducer xs (price+sumPrice)
 
deliveryCost :: [(string,Integer,Integer)] -> Integer
deliveryCost [] = 0
deliveryCost l = deliveryCostReducer l 0 
