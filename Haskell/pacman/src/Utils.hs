module Utils where

import System.Random

type Maze = [Corridor]
type Corridor = [Piece]
data Piece 
    = Food FoodType 
    | Wall 
    | Empty
data FoodType 
    = Big 
    | Little
instance Show Piece where
    show (Food Big) = "o"
    show (Food Little) = "."
    show (Wall) = "#"
    show (Empty) = " "

-- | This function makes a list of random numbers based on a seed
mkRds :: Int -- ^ Desired length of array
      -> Int -- ^ Seed
      -> [Int] -- ^ List of random numbers
mkRds n seed = take n (randomRs (0,99) (mkStdGen seed))
