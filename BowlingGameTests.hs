module Main where

import Test.HUnit
import BowlingGame

main = runTestTT tests

tests = TestList [testZeroScore,
	testOnesScore,
	testPutFramesTogetherWithNextOnes,
	testPointsOfFrame,
	testSpareScore]

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
	"A spare should value 10 plus the next roll" ~:
	points oneSpare ~?= 67

{-(verifica (concat (repeat 9 [0 0]) [[0 0 0]]) (separa-frames jogo-vazio))-}
{-(verifica (concat (repeat 9 [1 1]) [[1 1 0]]) (separa-frames jogo-de-uns))-}
{-(verifica (concat [[10 0]] (repeat 8 [3 3]) [[3 3 0]]) (separa-frames jogo-com-um-strike))-}
{-(verifica (concat [[10 0] [10 0]] (repeat 7 [3 3]) [[3 3 0]]) (separa-frames jogo-com-dois-strikes-seguidos))-}
{-(verifica (concat (repeat 9 [3 3]) [[10 5 5]]) (separa-frames jogo-com-strike-no-primeiro-turn-do-ultimo-frame))-}
{-(verifica (concat (repeat 9 [10 0]) [[10 10 10]]) (separa-frames jogo-perfeito))-}

{-(verifica 10 (soma-dois-primeiros [5 5 5]))-}
{-(verifica 15 (soma-dois-primeiros [10 5 5]))-}

{-(verifica 5 (pontos-do-ultimo-frame [2 3 0]))-}
{-(verifica 15 (pontos-do-ultimo-frame [5 5 5]))-}
{-(verifica 20 (pontos-do-ultimo-frame [10 5 5]))-}
{-(verifica 25 (pontos-do-ultimo-frame [10 10 5]))-}
{-(verifica 30 (pontos-do-ultimo-frame [10 10 10]))-}

{-(verifica 5 (segunda-jogada [[3 5]]))-}
{-(verifica 0 (segunda-jogada [[8 0]]))-}
{-(verifica 10 (segunda-jogada [[0 10]]))-}
{-(verifica 3 (segunda-jogada [[10 0] [3 0]]))-}
{-(verifica 5 (segunda-jogada [[10 5 1]]))-}
{-(verifica 10 (segunda-jogada [[10 0] [10 0 10]]))-}

{-(verifica 5 (pontos-do-frame [2 3] [[]]))-}
{-(verifica 5 (pontos-do-frame [2 3] [[5 5]]))-}
{-(verifica 15 (pontos-do-frame [5 5] [[5 5]]))-}
{-(verifica 20 (pontos-do-frame [10 0] [[5 5]]))-}
{-(verifica 30 (pontos-do-frame [10 0] [[10 10 10]]))-}
{-(verifica 20 (pontos-do-frame [10 0] [[10 0 10]]))-}
{-(verifica 28 (pontos-do-frame [10 0] [[10 0] [8 0]]))-}
{-(verifica 30 (pontos-do-frame [10 0] [[10 0] [10 0]]))-}

{-(verifica 67 (pontos jogo-com-um-spare))-}
{-(verifica 70 (pontos jogo-com-um-strike))-}
{-(verifica 76 (pontos jogo-com-dois-spares-seguidos))-}
{-(verifica 87 (pontos jogo-com-dois-strikes-seguidos))-}
{-(verifica 69 (pontos jogo-com-spare-no-ultimo-frame))-}
{-(verifica 74 (pontos jogo-com-strike-no-primeiro-turn-do-ultimo-frame))-}
{-(verifica 240 (pontos jogo-quase-perfeito))-}
{-(verifica 300 (pontos jogo-perfeito))-}
