module Maze where

import System.Random
import Data.List.Split

-- Maze = [[Piece]]
type Maze = [Corridor]
type Corridor = [Piece]

data Piece 
    = Food FoodType 
    | Wall 
    | Empty

instance Show Piece where
    show (Food Big) = "o"
    show (Food Little) = "."
    show (Wall) = "#"
    show (Empty) = " "

data FoodType 
    = Big 
    | Little

-- | Just the bottom and top rows of the Maze
limitLine :: Int 
          -> [Piece]
limitLine 0 = []
limitLine n = Wall:(limitLine (n-1))

-- | This function makes a list of random numbers based on a seed
mkRnds :: Int -- ^ Desired length of array
       -> Int -- ^ Seed
       -> [Int] -- ^ List of random numbers
mkRnds n seed = take n (randomRs (0,99) (mkStdGen seed))

-- | This function generates the Maze with a certain seed
generateMaze :: Int -- ^ Columns of the Maze
             -> Int -- ^ Lines of the Maze
             -> Int -- ^ Seed of the Maze
             -> Maze -- ^ Generated Maze
generateMaze col lin seed = 
    clearMaze
    where
        clearMaze = map generateCorridor rnds
        rnds = chunksOf (col-2) (mkRnds ((col-2)*(lin-2)) seed)

addWallsBox :: Int -- ^ Columns of the Maze
            -> Int -- ^ Lines of the Maze
            -> Maze -- ^ Maze to add the limit Walls
            -> Maze -- ^ Generated Maze
addWallsBox col lin maze =
    (limitLine col):(inside)++[limitLine col] -- Add the top and bottom Walls to the Walled Maze. Making the box.
    where
        inside = map reverse insideLeft -- Reverse back the Maze to its origin
        insideLeft = map (Wall:) (map (reverse) insideRight) -- Add the Walls to the left of the Maze
        insideRight = map (Wall:) maze -- Add the Walls on the right of the Maze

-- | This function generates random a Corridor
-- | from a list of random numbers.
generateCorridor :: [Int] -- ^ List of random numbers
                 -> Corridor -- ^ Resulting Corridor
generateCorridor [] = []
generateCorridor (h:t) =
    (generatePiece h):(generateCorridor t) -- Generate the Corridor recursively

-- | This generates the Piece from it's random
-- | number, using the list.
-- |
-- |  +--------+-------------+
-- |  | Values |    Piece    |
-- |  +--------+-------------+ 
-- |  |   3    | Food Big    |
-- |  |  0,69  | Food Little |
-- |  | 70,99  | Wall        |
-- |  +--------+-------------+
-- |
generatePiece :: Int -- ^ Piece random number
              -> Piece -- ^ Piece generated from the number
generatePiece n =
    if 0 <= n && n < 70 then -- [0,70[
        if n == 3 then Food Big -- 3
        else Food Little -- [0,70[ \ {3}
    else Wall -- [70,99]
