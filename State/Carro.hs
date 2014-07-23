module Carro where

data Carro = Carro { getKm :: Int }
instance Show Carro

anda :: Carro -> Carro
anda (Carro km) = Carro (km + 100)

andaMais :: Carro -> Carro
andaMais (Carro km) = Carro (km + 1000)
