module Game where

import Data.Array ( Ix(range), Array )

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
        board :: Board,
        crtPlayer :: Player,
        state :: State
    } deriving (Eq, Show)
