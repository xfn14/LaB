package com.andreubita.rastros;

import java.util.ArrayList;
import java.util.List;

public class Board {

    private final int ln;
    private final int col;

    private List<List<Piece>> board;
    private Pos pos1;
    private Pos pos2;
    private Pos crt;

    public Board(int ln, int col) {
        this.ln = ln;
        this.col = col;
        this.board = new ArrayList<>();
        this.pos1 = new Pos(0, this.ln - 1);
        this.pos2 = new Pos(this.col - 1, 0);
        this.crt = new Pos(this.col / 2, this.ln / 2);

        // Init board
        for (int i = 0; i < this.col; i++) {
            List<Piece> line = new ArrayList<>();
            for (int j = 0; j < this.col; j++) {
                line.add(Piece.CLEAR);
            }
            this.board.add(line);
        }

        // Set Piece.POS1, Piece.POS2 and Piece.CRT
        setPiece(this.pos1, Piece.POS1);
        setPiece(this.pos2, Piece.POS2);
        setPiece(this.crt, Piece.CRT);
    }

    public int getWidth() {
        return ln;
    }

    public int getY() {
        return col;
    }

    public Piece getPiece(Pos pos) {
        return this.board.get(pos.getY()).get(pos.getX());
    }

    public void setPiece(Pos pos, Piece piece) {
        if (0 <= pos.getX() && pos.getX() < this.col && 0 <= pos.getY() && pos.getY() < this.ln) {
            this.board.get(pos.getY()).set(pos.getX(), piece);
        }
    }

    public void printBoard(){
        for(List<Piece> line : this.board){
            for(Piece piece : line){
                System.out.print(piece.getName());
            }
            System.out.print('\n');
        }
    }

    public static class Pos {
        private final int x;
        private final int y;

        public Pos(int x, int y) {
            this.x = x;
            this.y = y;
        }

        public int getX() {
            return x;
        }

        public int getY() {
            return y;
        }
    }
}
