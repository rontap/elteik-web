package rontap.model;
import java.util.Random;
public enum Direction {
    DOWN(0, 1), LEFT(-1, 0), UP(0, -1), RIGHT(1, 0);
    
    Direction(int x, int y){
        this.x = x;
        this.y = y;
    }
    public final int x, y;

    public static Direction opposite(Direction ofDir) {
        return switch (ofDir) {
            case DOWN -> Direction.UP;
            case UP->Direction.DOWN;
            case LEFT-> Direction.RIGHT;
            case RIGHT-> Direction.LEFT;
        };
                
    }
    
    static Random random = new Random();
    
    
    static Direction Random() {
        Direction[] dirs = new Direction[]{
            Direction.DOWN,
            Direction.UP,
            Direction.LEFT,
            Direction.RIGHT
        };
        return dirs[Direction.random.nextInt(4)];
    }
}
