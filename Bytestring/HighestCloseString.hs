import System.Environment
import Control.Monad

safeTail []     = []
safeTail (x:xs) = xs

split :: (a -> Bool) -> [a] -> [[a]]
split pred []   = []
split pred list = firstPiece : split pred tailList
                where
                  (firstPiece, tailListWithSeparator) = span (not . pred) list
                  tailList = safeTail tailListWithSeparator

closing = readPrice . (!!4) . split (== ',')

readInt :: String -> Maybe (Int, String)
readInt str = case span (`elem` ['0'..'9']) str of
                  ([], _)        -> Nothing
                  (number, rest) -> Just (read number, rest)

readPrice :: String -> Maybe Int
readPrice str = do
                    (dollars, rest) <- readInt str
                    (cents, _) <- readInt $ tail rest
                    return (dollars * 100 + cents)

highestClose = maximum . (Nothing:) . map closing . lines

highestCloseFrom path = do
                            contents <- readFile path
                            print $ highestClose contents

main = do
           filePath <- liftM head getArgs
           highestCloseFrom filePath
