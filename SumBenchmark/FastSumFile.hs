module Main where

import Data.Maybe (fromJust)
import Data.List (foldl')
import qualified Data.ByteString.Lazy.Char8 as S

maybeInts :: S.ByteString -> [Maybe Int]
maybeInts = map (fmap (fromIntegral . fst) . S.readInt) . S.words

sumMaybes :: [Maybe Int] -> Int
sumMaybes = foldl' (+) 0 . map fromJust . takeWhile (/= Nothing)

main = S.getContents >>= (print . sumMaybes . maybeInts)
