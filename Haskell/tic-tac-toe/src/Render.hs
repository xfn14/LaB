module Render where

import Game
import Graphics.Gloss
import Data.Array

-- | Screen Width
width :: Int
width = 800

-- | Screen Height
height :: Int
height = 800

-- | Cell Width
cellWidth :: Float
cellWidth = fromIntegral width / fromIntegral 3

-- | Cell Height
cellHeight :: Float
cellHeight = fromIntegral height / fromIntegral 3

renderGame :: Game
           -> Picture
renderGame game =
    case state game of
        Running     -> drawBoard (board game)
        Over result -> drawOver result (board game)

drawOver :: Maybe Player
         -> Board
         -> Picture
drawOver result board =
    color (resultColor result) (drawBoard board)

drawBoard :: Board
          -> Picture
drawBoard board =
    Pictures [
        playerXCells board,
        playerOCells board,
        boardGrid
    ]

positionCell :: Cell
             -> (Int,Int)
             -> Pictures
positionCell cell (i,j) =
    translate x y (drawCell cell)
    where
        x = j * cellWidth + cellWidth * 0.5
        y = i * cellHeight + cellHeight * 0.5

drawCell :: Cell
         -> Picture
drawCell Nothing = Blank
drawCell (Just X) =
    Pictures [
        rotate 45 $ rectangleSolid length 15,
        rotate (-45) $ rectangleSolid length 15
    ]
    where length = min cellWidth cellHeight * 0.25
drawCell (Just O) =
    thickCircle radius 15
    where radius = min cellWidth cellHeight * 0.75

-- | TODO
boardGrid :: Picture
boardGrid =
    Pictures [
        Line [(), ()],
        Line [(), ()],
        Line [(), ()],
        Line [(), ()]
    ]

resultColor :: Maybe Player
            -> Color
resultColor Nothing = greyN 0.5
resultColor (Just X) = makeColor 255 0 0 255
resultColor (Just O) = makeColor 0 0 255 255
