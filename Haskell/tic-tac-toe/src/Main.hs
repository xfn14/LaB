module Main where

import Game
import Logic
import Render
import Graphics.Gloss
import Graphics.Gloss.Data.Color

main :: IO()
main =
    play
        window
        bckgColor
        fr
        initGame
        renderGame
        gameListener
        (const id)

-- | Settings

-- | Frame Rate
fr :: Int
fr = 30

-- | Window Settings
window :: Display
--window = FullScreen -- Display FullScreen
window = InWindow "Tic-Tac-Toe" (width,height) (0,0) -- Display in a window with the given name, size and position. 

-- | Background Color
bckgColor :: Color
bckgColor = makeColor 255 255 255 255

initGame :: Game
initGame = 
    Game {
        board = initBoard boardRange $ zip (range boardRange) (repeat Nothing),
        crtPlayer = X,
        state = Running
    }
    where boardRange = ((0,0), (2,2))