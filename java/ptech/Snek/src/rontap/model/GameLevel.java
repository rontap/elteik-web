package rontap.model;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;
import javax.swing.Timer;
import rontap.model.*;



public class GameLevel {
    public final String        gameID;
    public final int           rows, cols;
   
    public Position            player = new Position(0, 0);
    public Sneak sneak ;
    public ArrayList<Stone> stones = new ArrayList<>();
    private int                numBoxes, numBoxesInPlace, numSteps;
    public Reward reward;
    
    
    public GameLevel(int _rows,int _cols, String gameID){
        sneak = new Sneak();
        
        this.gameID = gameID;
        int c = 0;
        
        for (int i = 0; i < 10; i++) 
        {
            stones.add(Stone.Generate(sneak));
        }
        
        reward = Reward.Generate(sneak,stones);
        
        //for (String s : gameLevelRows) if (s.length() > c) c = s.length();
        this.rows = _rows;
        this.cols = _cols;
        numBoxes = 0;
        numBoxesInPlace = 0;
        numSteps = 0;
        
  

    }
    
     public Boolean isDead() {
        // is snake out of bounds
        Boolean isOverStone = false;
        
        // is sneak over stone
        for (Stone stone : stones) {
                if ( stone.pos.eq(sneak.head()) ) {
                    return true;
                }
            }
        
        // is snake over snake
        for (int i = 0 ; i < sneak.size()-1 ; i++) {
                if ( sneak.snek.get(i).eq(sneak.head()) ) {
                    return true;
                }
            }
        
        return !sneak.head().isValidPosition(cols,rows);
    }
       
    public void update() {
        if (sneak.head().eq(reward.pos)) {
            reward = Reward.Generate(sneak,stones);
            sneak.grow();
        } else {
            sneak.next(); 
        }
    }
    
   

    
}
