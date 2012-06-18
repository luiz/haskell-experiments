import qualified Data.ByteString.Lazy.Char8 as L
import System.Environment
import Control.Monad

closing = readPrice . (!!4) . L.split ','

readPrice :: L.ByteString -> Maybe Int
readPrice str = do
    (dollars, rest) <- L.readInt str
    (cents, more) <- L.readInt (L.tail rest)
    return (dollars * 100 + cents)

highestClose = maximum . (Nothing:) . map closing . L.lines

highestCloseFromStdin = do
    contents <- L.getContents
    print $ highestClose contents

main = highestCloseFromStdin
