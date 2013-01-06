import System.Environment
import System.IO
import Control.Monad

fromSig :: (Read a) => String -> [a]
fromSig = map read . lines

toSig :: (Show a) => [a] -> String
toSig = unlines . map show

sigDiff :: [Double] -> [Double] -> [Double]
sigDiff = zipWith (-)

main = do
    (f1:f2:_) <- getArgs
    sig1 <- liftM fromSig . readFile $ f1
    sig2 <- liftM fromSig . readFile $ f2
    putStrLn $ toSig $ sigDiff sig1 sig2
