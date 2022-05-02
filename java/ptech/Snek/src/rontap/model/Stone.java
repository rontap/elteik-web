/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rontap.model;

import java.util.Random;
import static rontap.model.Game.GAMESIZE_X;
import static rontap.model.Game.GAMESIZE_Y;

/**
 *
 * @author rontap
 */
public class Stone {
    Position pos;
    Stone(Position _pos) {
        pos = _pos;
    }
    public static Stone Generate(Sneak snek) {
        Position pos = null;
        do {
            Position maybePos = Position.random(GAMESIZE_Y, GAMESIZE_X);
            Boolean found = false;
            for (Position snekPos : snek.snek) {
                if ( snekPos.eq(maybePos) ) {
                    found = true;
                    break;
                }
            }
            if (!found) {
                pos = maybePos;
            }
        } while (pos == null);
        
        return new Stone(pos);
    };
    public int x() {
        return pos.x;
    }
    public int y() {
        return pos.y;
    }
    
}
