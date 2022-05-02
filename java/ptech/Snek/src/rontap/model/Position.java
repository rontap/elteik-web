package rontap.model;

import java.util.Random;

public class Position {
    public int x, y;

    public Position(int x, int y) {
        this.x = x;
        this.y = y;
    }    
    
    public Position translate(Direction d){
        return new Position(x + d.x, y + d.y);
    }
    
    public boolean isValidPosition(int cols, int rows){
        return (x >= 0 && y >= 0 && x < cols && y < rows);
    }
    
    public static Position random(int cols, int rows) {
          Random random = new Random();
          return new Position( random.nextInt(cols), random.nextInt(rows) );
    }
    public Boolean eq(Position pos) {
        return pos.x == x && pos.y == y;
    }
}
