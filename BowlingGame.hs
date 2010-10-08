module BowlingGame (
	BowlingGame(..),
	Frame,
	points,
	putFramesTogetherWithNextOnes,
	pointsOfFrame) where

import List

data BowlingGame = BowlingGame [Frame]
type Frame = [Roll]
type Roll = Int

putFramesTogetherWithNextOnes :: [Frame] -> [(Frame, Frame, Frame)]
putFramesTogetherWithNextOnes frames = zip3 frames ((tail frames) ++ [[0, 0]]) ((tail (tail frames)) ++ [[0, 0], [0, 0]])

value frame = foldl (+) 0 frame
pointsOfFrame (frame, next, afterNext) = (if (value frame) == 10 then (value frame) + (head next) else value frame) + (if (head frame) == 10 then (head (tail next)) else 0)
pointsOfFrames frames = map pointsOfFrame (putFramesTogetherWithNextOnes frames)

flatten :: [[a]] -> [a]
flatten = foldl (++) []

points (BowlingGame frames) = foldl (+) 0 (pointsOfFrames frames)
