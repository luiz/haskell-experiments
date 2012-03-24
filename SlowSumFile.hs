{-
 -main = do
 -    contents <- getContents
 -    print (sumFile contents)
 -  where sumFile = sum . map read . words
 -}

main = getContents >>= (print . sumFile)
    where sumFile = sum . map read . words
