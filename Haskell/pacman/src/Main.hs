module Main where

import Utils

-- Just a small test

-- | Settings

-- | Frame Rate
fr :: Int
fr = 30

-- | Window Settings
window :: Display
--window = FullScreen -- Display FullScreen
window = InWindow "PacMan" (1400,600) (0,0) -- Display in a window with the given name, size and position. 

main :: IO()
main = do
    seed <- randomRIO (0,9999)
    play
        ds
        (greyN 0.0)
        fr
        initState
