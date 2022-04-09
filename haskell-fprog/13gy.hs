type Year = Int

data Month = Jan | Feb | Mar | Apr | May | Jun | Jul | Aug | Sep | Oct | Nov | Dec

numberOfDays :: Year -> Month -> Int
numberOfDays _ Apr = 30
numberOfDays _ Jun = 30
numberOfDays _ Sep = 30
numberOfDays _ Nov = 30

numberOfDays year Feb 
 | year `mod` 400 == 0 = 29
 | year `mod` 100 == 0 = 28
 | year `mod` 4   == 0 = 29
 | otherwise = 28

numberOfDays _ _ = 31