module Render where

import Maze
import Graphics.Gloss

-- | Convert a Maze to a Gloss Picture
drawMaze :: Maze -- ^ Maze to draw
         -> Int -- ^ Corridor number (starts in 0)
         -> [Picture] -- ^ Generated Maze Picture
drawMaze [] _ = []
drawMaze (h:t) lin = (drawCorridor h lin 0) ++ (drawMaze t (lin+1))

-- | Convent a Corridor to a Gloss Picture
drawCorridor :: Corridor -- ^ Corridor to draw
             -> Int -- ^ Corridor number
             -> Int -- ^ Column number (starts in 0)
             -> [Picture] -- ^ Generated Corridor Picture
drawCorridor [] _ _ = []
drawCorridor (h:t) lin col = (drawPiece h lin col):(drawCorridor t lin (col+1))

-- | Convert a Piece to a Gloss Picture
drawPiece :: Piece -- ^ Piece to draw
          -> Int -- ^ Corridor number
          -> Int -- ^ Column number
          -> Picture -- ^ Generated Piece Picture
drawPiece p lin col =
    translate (realToFrac (col*pieceSize)) (realToFrac (lin*pieceSize))
        (
            case p of
                Empty -> Blank
                Wall -> color green (rectangleSolid (realToFrac pieceSize) (realToFrac pieceSize)) -- rectangleSolid is using center of rect
                Food Little -> color (greyN 0.5) (circleSolid (realToFrac $ div pieceSize 2 - (div pieceSize 3)))
                Food Big -> color (greyN 0.5) (circleSolid (realToFrac $ div pieceSize 2 - 5))
        )