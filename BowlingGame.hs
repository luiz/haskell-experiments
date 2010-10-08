module BowlingGame (
	BowlingGame(..),
	points) where

import List

data BowlingGame = BowlingGame [Roll]
type Roll = Int

points2 lastFrame 10 = foldl (+) 0 lastFrame
points2 (a:b:c:rest) rolls | a == 10         = 10 + b + c + (points2 (b:c:rest) (rolls + 1))
points2 (a:b:c:rest) rolls | (a + b) == 10   = 10 + c + (points2 (c:rest) (rolls + 1))
points2 (a:b:rest) rolls = a + b + (points2 rest (rolls + 1))
points2 _ _ = 0

points (BowlingGame rolls) = points2 rolls 1
