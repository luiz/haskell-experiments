module Main where

import Test.HUnit
import BowlingGame

main = runTestTT tests

tests = TestList [testZeroScore,
	testOnesScore,
	testPutFramesTogetherWithNextOnes,
	testPointsOfFrame,
	testSpareScore,
	testStrikeScore,
	testPerfectGames]

noGood = BowlingGame (replicate 10 [0, 0])
onePins = BowlingGame (replicate 10 [1, 1])
oneSpare = BowlingGame ([[5, 5]] ++ (replicate 9 [3, 3]))
oneStrike = BowlingGame ([[10, 0]] ++ (replicate 9 [3, 3]))
twoConsecutiveSpares = BowlingGame ([[5, 5], [5, 5]] ++ (replicate 8 [3, 3]))
twoConsecutiveStrikes = BowlingGame ([[10, 0], [10, 0]] ++ (replicate 8 [3, 3]))
spareInLastFrame = BowlingGame ((replicate 9 [3, 3]) ++ [[5, 5, 5]])
strikeFirstTurnOfLastFrame = BowlingGame ((replicate 9 [3, 3]) ++ [[10, 5, 5]])
almostPerfect = BowlingGame ((replicate 9 [10, 0]) ++ [[0, 0, 0]])
perfect = BowlingGame ((replicate 9 [10, 0]) ++ [[10, 10, 10]])

testZeroScore =
	"Game with no hit pins scores zero" ~:
	points noGood ~?= 0

testOnesScore =
	"Game with one pin hit in every turn scores 20" ~:
	points onePins ~?= 20

testPutFramesTogetherWithNextOnes =
	"Frames should be together with next ones in a single list cell" ~:
	putFramesTogetherWithNextOnes [[5, 5], [6, 6], [7, 7]] ~?= [([5, 5], [6, 6], [7, 7]), ([6, 6], [7, 7], [0, 0]), ([7, 7], [0, 0], [0, 0])]

testThirdRoll =
	TestList[
		"Third roll after a strike followed by a strike should be the first of the third frame" ~:
		thirdRoll ([10, 0], [10, 0], [5, 3]) ~?= 5,
		"Third roll after a strike followed by not a strike should be the second roll of the second frame" ~:
		thirdRoll ([10, 0], [3, 6], [4, 2]) ~?= 6,
		"Third roll after a strike followed by the last frame should be the second roll of that frame" ~:
		thirdRoll ([10, 0], [10, 1, 3], [0, 0]) ~?= 1
	]

testPointsOfFrame =
	TestList[
		"Frame with no spare or strike should value the sum of rolls" ~:
		pointsOfFrame ([5, 3], [5, 3], [5, 3]) ~?= 8,
		"Frame with a spare should value 10 plus its next roll" ~:
		pointsOfFrame ([5, 5], [3, 3], [3, 3]) ~?= 13,
		"Frame with a strike should value 10 plus its next 2 rolls" ~:
		pointsOfFrame ([10, 0], [5, 3], [3, 3]) ~?= 18,
		"Frame with a strike followed by another strike should value 20 plus the roll after the second strike" ~:
		pointsOfFrame ([10, 0], [10, 0], [4, 5]) ~?= 24
	]

testSpareScore =
	TestList[
		"A spare should value 10 plus the next roll" ~:
		points oneSpare ~?= 67,
		"A spare followed by a spare should value 10 plus the first roll of the second spare" ~:
		points twoConsecutiveSpares ~?= 76,
		"A spare should be considered a normal play in the last frame" ~:
		points spareInLastFrame ~?= 69
	]

testStrikeScore =
	TestList[
		"A strike should value 10 plus the next two rolls" ~:
		points oneStrike ~?= 70,
		"A strike followed by a strike should value 20 plus the next roll after the second strike" ~:
		points twoConsecutiveStrikes ~?= 87,
		"A strike should be counted as a normal play in the last frame" ~:
		points strikeFirstTurnOfLastFrame ~?= 74
	]

testPerfectGames =
	TestList[
		"A game with strikes in the 9 first frames and zero score in the last frame should value 240" ~:
		points almostPerfect ~?= 240,
		"A perfect game should value 300" ~:
		points perfect ~?= 300
	]

{-(verifica 5 (pontos-do-ultimo-frame [2 3 0]))-}
{-(verifica 15 (pontos-do-ultimo-frame [5 5 5]))-}
{-(verifica 20 (pontos-do-ultimo-frame [10 5 5]))-}
{-(verifica 25 (pontos-do-ultimo-frame [10 10 5]))-}
{-(verifica 30 (pontos-do-ultimo-frame [10 10 10]))-}

{-(verifica 240 (pontos jogo-quase-perfeito))-}
{-(verifica 300 (pontos jogo-perfeito))-}
