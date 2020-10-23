package com.andreubita.rastros;

public enum Piece {
    CRT('#'),
    RASTRO('+'),
    POS1('1'),
    POS2('2'),
    CLEAR('.');

    private char name;

    Piece(char name){
        this.name = name;
    }

    public char getName() {
        return name;
    }
}
