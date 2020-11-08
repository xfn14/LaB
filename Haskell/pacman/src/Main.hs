module Main where

import Maze ( generateMaze )
import System.Random ( randomRIO )
import Graphics.Gloss

-- | Settings

-- | Frame Rate
fr :: Int
fr = 30

-- | Background Color
background :: Color
background = 
    --greyN (0.5)
    black

-- | Window Settings
window :: Display
window =
    --FullScreen -- Display FullScreen
    InWindow "PacMan" (1400,600) (0,0) -- Display in a window with the given name, size and position. 

main :: IO()
main =
    --seed <- randomRIO (0,9999)
    display window background cirlcee
    where
        maze = generateMaze 20 20 111

cirlcee :: Picture
cirlcee = circle 80

