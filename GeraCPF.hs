import System.Environment
import qualified Data.List as L

digitos :: Int -> [Int]
digitos n = map read $ lines $ L.intersperse '\n' $ show n

completaCom :: a -> Int -> [a] -> [a]
completaCom elem tamanho lista
    | length lista >= tamanho = lista
    | otherwise               = elem : (completaCom elem (tamanho - 1) lista)

somaMultiplicandoPor :: Num a => [a] -> [a] -> a
somaMultiplicandoPor l1 l2 = sum $ zipWith (*) l1 l2

dv :: [Int] -> [Int] -> Int
dv mascara digitos =
    let
        soma  = digitos `somaMultiplicandoPor` mascara
        mod11 = soma `mod` 11
    in
        if mod11 >= 2
        then 11 - mod11
        else 0

dv1 :: [Int] -> Int
dv1 = dv (reverse [2..10])

dv2 :: [Int] -> Int
dv2 = dv (reverse [2..11])

montaCpf :: Int -> String
montaCpf n =
    let
        principal = completaCom 0 9 $ digitos n
        d1 = dv1 principal
        d2 = dv2 $ principal ++ [d1]
    in
        concat $ map show $ principal ++ [d1, d2]

main = interact $ montaCpf . read
