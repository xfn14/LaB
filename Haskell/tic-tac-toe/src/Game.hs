module Game where

import Render
import Data.Array

data Player
    = X
    | O
    deriving (Eq, Show)

type Cell = Maybe Player

data State
    = Running
    | Over (Maybe Player)
    deriving (Eq, Show)

type Board = Array (Int,Int) Cell

data Game
    = Game {
        board :: Board
        crtPlayer :: Player
        state :: State
    } deriving (Eq, Show)

initGame :: Game
initGame = 
    Game {
        board = initBoard boardRange $ zip (range boardRange) (repeat Nothing)
        crtPlayer = X,
        state = Running
    }
    where boardRange = ((0,0), (2,2))