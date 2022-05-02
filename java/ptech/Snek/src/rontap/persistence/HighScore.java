package rontap.persistence;

import java.util.Objects;
import rontap.model.GameID;

public class HighScore {
    public final String difficulty;
    public final int level;
   
   
    public final String name;
    public final int steps;
    
    public HighScore(String name, int steps){
        this.difficulty = "";
        this.level = 1;
        
        this.name = name;
        this.steps = steps;
    }
    
    

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 89 * hash + Objects.hashCode(this.name);
        hash = 89 * hash + this.level;
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final HighScore other = (HighScore) obj;
        if (this.steps != other.steps) {
            return false;
        }
        if (!Objects.equals(this.name, other.name)) {
            return false;
        }
        return true;
    }   

    @Override
    public String toString() {
        return name + "-: " + steps;
    }
    
    
}
