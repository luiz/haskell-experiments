import System.Environment
import Data.List

joinLinesOf :: [String] -> String
joinLinesOf = unlines . map concat . map (intersperse ",") . transpose . map lines

generateHeader :: [String] -> String
generateHeader fileNames = concatWith "," fileNames
                         where
                           concatWith separator = concat . intersperse separator

main = do
    files <- getArgs
    fileContents <- mapM readFile files
    putStrLn $ generateHeader files
    putStrLn $ joinLinesOf fileContents
