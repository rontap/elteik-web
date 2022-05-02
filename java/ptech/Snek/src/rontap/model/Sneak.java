/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rontap.model;

import java.util.ArrayList;

/**
 *
 * @author rontap
 */
public class Sneak {
    public Direction look;
    public ArrayList<Position> snek;
    
    
    public Sneak() {
        look = Direction.Random();
        snek = new ArrayList<>();
        snek.add( new Position(5,5) );
        snek.add( new Position(5,5).translate(
                Direction.opposite(look)) );
        
    }
    
    Position head() {       
        return snek.get(snek.size()-1);
    }
    Position tail() {
        return snek.get(0);
    }
    public void next() {
        snek.add( head().translate(look) );
        snek.remove(0);
    }
    public void grow() {
        snek.add( head().translate(look) );
    }
    public int size() {
        return snek.size();
    }
    
    Boolean isOutsideBounds() {
            return false;
    }
}
