{-
 -main = do
 -    contents <- getContents
 -    print (sumFile contents)
 -  where sumFile = sum . map read . words
 -}
import Data.List (foldl')

main = getContents >>= (print . sumFile)
    where sumFile = sum' . map read . words
          sum'    = foldl' (+) 0
