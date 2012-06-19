import qualified Data.List as L

-- Calculates the first derivative of a time-discrete, floating point signal, using three points

wrapWithTwoAfter :: [a] -> [(a, a)]
wrapWithTwoAfter list = zip list (drop 2 list)

derivate :: (Double, Double) -> Double
derivate (fbefore, fafter) = (fafter - fbefore) * 0.5

derivateSignal :: [Double] -> [Double]
derivateSignal = map derivate . wrapWithTwoAfter

parseSignal :: String -> [Double]
parseSignal = map read . lines

outputSignal :: [Double] -> String
outputSignal = concat . L.intersperse "\n" . map show

main = interact (outputSignal . derivateSignal . parseSignal)
