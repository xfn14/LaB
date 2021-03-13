module Play where

import Types
import Utils

baseVelocity :: Double
baseVelocity = 1

-- TODO Detetar mudança de nivel
play :: Play
     -> State
     -> State
play j@(Move i o) state@(State maze players lvl) =
    (State finalMaze finalPlayers lvl)
    where
        finalPlayers = setIndexList (findPlayerState i state 0) players finalPlayer
        player = (getIndexList (findPlayerState i state 0) players)
        (finalPlayer,finalMaze) = playPlayerMaze j player maze

playPlayerMaze :: Play
               -> Player
               -> Maze
               -> (Player,Maze)
playPlayerMaze _ (Ghost ghostState) maze = undefined
playPlayerMaze j@(Move _ newOri) player@(Pacman pacState@(PacState (id,coord,velocity,ori,points,lives) timeMega mouth mode)) maze
    | newOri == ori = (
        (Pacman (PacState (id,newCoord,velocity,newOri,newPoints,lives) (reduceTimeMega timeMega) (changePacmanMouth mouth) mode)),
        replaceElemInMaze newCoord (Pacman (PacState (id,newCoord,velocity,newOri,newPoints,lives) (reduceTimeMega timeMega) (changePacmanMouth mouth) mode)) (replaceElemInMaze coord Empty maze)
    )
    | otherwise = (
        (Pacman (PacState (id,coord,baseVelocity,newOri,points,lives) (reduceTimeMega timeMega) (changePacmanMouth mouth) mode)),
        replaceElemInMaze coord (Pacman (PacState (id,coord,baseVelocity,newOri,points,lives) (reduceTimeMega timeMega) (changePacmanMouth mouth) mode)) maze
    )
    where
        newCoord = 
            case rltvPiece of
                Wall -> coord
                _ -> getRelativeCoord coord newOri
        newPoints =
            case rltvPiece of
                Food Little -> points + 1
                Food Big -> points + 5
                _ -> points
        rltvPiece = getRelativePiece coord ori maze

changePacmanMouth :: Mouth
                  -> Mouth
changePacmanMouth Open = Closed
changePacmanMouth Closed = Open

-- TODO Change valores
reduceTimeMega :: Double
               -> Double
reduceTimeMega x =
    if x == 0 then 0
    else x

getRelativePiece :: Coords
                 -> Orientation
                 -> Maze
                 -> Piece
getRelativePiece coord ori maze =
    getCoordMaze (getRelativeCoord coord ori) maze

getRelativeCoord :: Coords
                 -> Orientation
                 -> Coords
getRelativeCoord c@(x,y) ori =
    case ori of
        L -> (x,y-1)
        R -> (x,y+1)
        U -> (x+1,y)
        D -> (x-1,y)
        Null -> c

getCoordMaze :: Coords
             -> Maze
             -> Piece
getCoordMaze (x,y) maze =
    getIndexList (y-1) (getIndexList (x-1) maze)

findPlayerState :: Int
                -> State
                -> Int -- ^ Start with 0 to init the function
                -> Int
findPlayerState i (State a (h:t) c) p =
    if crtId == i then p
    else findPlayerState i (State a t c) (p+1)
    where
        crtId = getPlayerID h
