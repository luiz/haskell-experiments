module BowlingGame (
	BowlingGame(..),
	Frame,
	points,
	putFramesTogetherWithNextOnes,
	pointsOfFrame,
	thirdRoll) where

import List

data BowlingGame = BowlingGame [Frame]
type Frame = [Roll]
type Roll = Int

putFramesTogetherWithNextOnes :: [Frame] -> [(Frame, Frame, Frame)]
putFramesTogetherWithNextOnes frames = zip3 frames ((tail frames) ++ [[0, 0]]) ((tail (tail frames)) ++ [[0, 0], [0, 0]])

thirdRoll ([10, 0], [10, 0], afterNext) = head afterNext
thirdRoll ([10, 0], next, _) = head (tail next)
thirdRoll ([a, b, c], _, _) = 0

pins frame = foldl (+) 0 frame
pointsOfFrame plays@([10, 0], next, afterNext) = 10 + (head next) + (thirdRoll plays)
pointsOfFrame (frame, next, _) | (pins frame) == 10 = 10 + (head next)
pointsOfFrame (frame, _, _) = (pins frame)

pointsOfFrames frames = map pointsOfFrame (putFramesTogetherWithNextOnes frames)

flatten :: [[a]] -> [a]
flatten = foldl (++) []

points (BowlingGame frames) = foldl (+) 0 (pointsOfFrames frames)
