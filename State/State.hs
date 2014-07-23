module State where

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

runState :: State s t -> s -> t
runState st = snd . transitionFunction st
