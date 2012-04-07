import System.Random
import Control.Monad
import Control.Monad.State

rollNDiceIO :: Int -> IO [Int]
rollNDiceIO 0 = return []
rollNDiceIO n = liftM2 (:) (randomRIO (1, 6)) (rollNDiceIO (n - 1))

type GeneratorState = State StdGen

rollDie :: GeneratorState Int
rollDie = do
    generator <- get
    let (randomValue, newGenerator) = randomR (1, 6) generator
    put newGenerator
    return randomValue

rollNDice :: Int -> GeneratorState [Int]
rollNDice 0 = return []
rollNDice n = liftM2 (:) rollDie (rollNDice (n - 1))
