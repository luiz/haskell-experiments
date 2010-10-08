module Main where

import Test.HUnit
import BowlingGame

main = runTestTT tests

tests = TestList [testZeroScore,
	testOnesScore,
	testSpareScore,
	testStrikeScore,
	testPerfectGames]

noGood = BowlingGame (replicate 20 0)
onePins = BowlingGame (replicate 20 1)
oneSpare = BowlingGame ([5, 5] ++ (replicate 18 3))
oneStrike = BowlingGame ([10] ++ (replicate 18 3))
twoConsecutiveSpares = BowlingGame ([5, 5, 5, 5] ++ (replicate 16 3))
twoConsecutiveStrikes = BowlingGame ([10, 10] ++ (replicate 16 3))
spareInLastFrame = BowlingGame ((replicate 18 3) ++ [5, 5, 5])
strikeFirstTurnOfLastFrame = BowlingGame ((replicate 18 3) ++ [10, 5, 5])
almostPerfect = BowlingGame ((replicate 9 10) ++ [0, 0, 0])
perfect = BowlingGame ((replicate 9 10) ++ [10, 10, 10])

testZeroScore =
	"Game with no hit pins scores zero" ~:
	points noGood ~?= 0

testOnesScore =
	"Game with one pin hit in every turn scores 20" ~:
	points onePins ~?= 20

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
