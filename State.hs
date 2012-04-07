import Control.Monad

data State s t = State { transitionFunction :: s -> (s, t) }

instance Monad (State s) where
    return value = State (\s -> (s, value))
    oldState >>= stateTransition = State (\s ->
        let
            (newState, output) = transitionFunction oldState s
        in
            transitionFunction (stateTransition output) newState
        )

multiplyByTwo :: Int -> State String Int
multiplyByTwo n = State $ \s -> (s ++ "Multiplied by two. ", n * 2)

main = putStrLn . show $ multiplyByFourWithState "Hi, I'm gonna multiply. "
    where multiplyByFourWithState initialState = transitionFunction (return 1 >>= multiplyByTwo >>= multiplyByTwo) initialState
