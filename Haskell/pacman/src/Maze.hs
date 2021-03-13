module Maze where

import Types
import Utils ( getIndexList, setIndexList )
import System.Random ( mkStdGen, Random(randomRs) )
import Data.List.Split ( chunksOf )

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

-- | Size of each piece in display
pieceSize :: Int
pieceSize = 40 -- value in px

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
    if col < 15 || lin < 10 then error "Maze needs to be at least 15x10" -- Invalid Maze size
    else ghostHouseEven col lin midTunel -- Final generated Maze
    where
        midTunel = addExits col lin boxed -- Maze with the tunel on the sides
        boxed = addWallsBox col lin clearMaze -- Maze with the outside walls
        clearMaze = map generateCorridor rnds -- The inside of the Maze
        rnds = chunksOf (col-2) (mkRnds ((col-2)*(lin-2)) seed) -- List of random numbers generated from a seed

-- TODO
-- | Add the Ghost House to the Maze
addGhostHouse :: Int -- ^ Columns of the Maze
              -> Int -- ^ Lines of the Maze
              -> Maze -- ^ Maze to add the ghost house
              -> Maze -- ^ Maze with the Ghost House
addGhostHouse col lin maze = undefined -- temp
    --if mod col 2 == 0 then ghostHouseEven col lin maze
    --else ghostHouseOdd col lin maze

-- | Add the Ghost House to Even Maze
ghostHouseEven :: Int -- ^ Columns of the Maze
               -> Int -- ^ Lines of the Maze
               -> Maze -- ^ Maze the add the ghost house
               -> Maze -- ^ Resulting Maze with the Even Ghost House
ghostHouseEven col lin maze =
    setIndexList (midPoint+1) (setIndexList midPoint (setIndexList (midPoint-1) (setIndexList (midPoint+2) (setIndexList (midPoint-2) maze topBotLine) topBotLine) house1) house2) house3
    where
        midPoint =
            if mod lin 2 == 0 then (div lin 2) - 1
            else (div lin 2)
        topBotLine = (take ((div col 2)-5) (getIndexList (midPoint-2) (maze))) ++ [Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty] ++ (drop ((div col 2)+5) (getIndexList (midPoint-2) (maze)))
        house1 = (take ((div col 2)-5) (getIndexList (midPoint-1) (maze))) ++ [Empty,Wall,Wall,Wall,Empty,Empty,Wall,Wall,Wall,Empty] ++ (drop ((div col 2)+5) (getIndexList (midPoint-1) (maze)))
        house2 = (take ((div col 2)-5) (getIndexList (midPoint) (maze))) ++ [Empty,Wall,Empty,Empty,Empty,Empty,Empty,Empty,Wall,Empty] ++ (drop ((div col 2)+5) (getIndexList (midPoint) (maze)))
        house3 = (take ((div col 2)-5) (getIndexList (midPoint+1) (maze))) ++ [Empty,Wall,Wall,Wall,Wall,Wall,Wall,Wall,Wall,Empty] ++ (drop ((div col 2)+5) (getIndexList (midPoint+1) (maze)))

-- | Add side Exits to teleport to other side of the Maze
addExits :: Int -- ^ Columns of the Maze
         -> Int -- ^ Lines of the Maze
         -> Maze -- ^ Maze to add the exits (Must have WallBox)
         -> Maze -- ^ Maze with the Exits
addExits col lin maze =
    if mod lin 2 == 0 then step4
    else step2
    where
        -- (old) fromIntegral $ floor (fromIntegral lin/2)
        step1 = setIndexList (div lin 2) maze (setIndexList 0 (getIndexList (div lin 2) maze) (Empty))
        step2 = setIndexList (div lin 2) step1 (setIndexList (col-1) (getIndexList (div lin 2) step1) (Empty))
        step3 = setIndexList ((div lin 2)-1) step2 (setIndexList (0) (getIndexList ((div lin 2)-1) step2) (Empty))
        step4 = setIndexList ((div lin 2)-1) step3 (setIndexList (col-1) (getIndexList ((div lin 2)-1) step3) (Empty))

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
