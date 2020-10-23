package com.andreubita.rastros;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class Main {

    public static void main(String[] args) {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        int ln = -1, col = -1;
        System.out.println("Number of columns: ");
        while(col == -1){
            try {
                col = Integer.parseInt(reader.readLine());
            } catch (IOException | NumberFormatException e) {
                System.out.println("Please enter a number.");
            }
        }

        System.out.println("Number of lines: ");
        while(ln == -1){
            try {
                ln = Integer.parseInt(reader.readLine());
            } catch (IOException | NumberFormatException e) {
                System.out.println("Please enter a number.");
            }
        }

        System.out.println("\n\nColumns: " + col + "; Lines: " + ln);
        Board board = new Board(ln, col);
        board.printBoard();
    }
}
