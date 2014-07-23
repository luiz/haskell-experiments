module StateCarro where

import Carro as C
import State

type SCarro = State Carro

liftS :: (a -> a) -> State a ()
liftS f = State (\s -> (f s, ()))

liftS2 :: (a -> b) -> State a b
liftS2 f = State (\s -> (s, f s))

anda :: SCarro ()
anda = liftS C.anda

andaMais :: SCarro ()
andaMais = liftS C.andaMais

getKm :: SCarro Int
getKm = liftS2 C.getKm
