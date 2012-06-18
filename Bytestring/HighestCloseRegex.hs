import qualified Data.ByteString.Lazy.Char8 as L
import Text.Regex.TDFA
import System.Environment
import Control.Monad

closing = readPrice . (!!4) . L.split ','

toInt str = int
          where
            Just (int, rest) = L.readInt str

readPrice :: L.ByteString -> Maybe Int
readPrice str = do
    matches <- str =~~ "([0-9]+)[.]([0-9]{2})" :: Maybe (MatchResult L.ByteString)
    let (dollars : cents : _ ) = map toInt $ mrSubList matches
    return (dollars * 100 + cents)

highestClose = maximum . (Nothing:) . map closing . L.lines

highestCloseFrom path = do
    contents <- L.readFile path
    print $ highestClose contents

main = do
    filePath <- liftM head getArgs
    highestCloseFrom filePath
