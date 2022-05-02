package rontap.model;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Scanner;

import rontap.persistence.*;
import rontap.res.ResourceLoader;

public class Game {
    private final HashMap<String, HashMap<Integer, GameLevel>> gameLevels;
    private GameLevel gameLevel = null;
    public final Database database;
    private boolean isBetterHighScore = false;

    public Game() {
        gameLevels = new HashMap<>();
        database = new Database();
        loadGame();
    }
    final static public int GAMESIZE_X = 15;
    final static public int GAMESIZE_Y = 20;

    public void loadGame() {
        //gameLevel = new GameLevel(gameLevels.get(gameID.difficulty).get(gameID.level));
        gameLevel = new GameLevel(GAMESIZE_X,GAMESIZE_Y,"ZSa");
        isBetterHighScore = false;
    }


    public boolean step(Direction d) {
        return false;
    }

    // ------------------------------------------------------------------------
    // Getter methods
    // ------------------------------------------------------------------------

    public Collection<String> getDifficulties() {
        return gameLevels.keySet();
    }

    public Collection<Integer> getLevelsOfDifficulty(String difficulty) {
        if (!gameLevels.containsKey(difficulty)) return null;
        return gameLevels.get(difficulty).keySet();
    }

    public boolean isLevelLoaded() {
        return true;
    }

    public int getLevelRows() {
        return gameLevel.rows;
    }

    public int getLevelCols() {
        return gameLevel.cols;
    }
    
    public  GameLevel level() {
        return gameLevel;
    }

    public boolean isBetterHighScore() {
        return isBetterHighScore;
    }

    public ArrayList<HighScore> getHighScores() {
        return database.getHighScores();
    }

    private void addNewGameLevel(GameLevel gameLevel) {
        database.storeHighScore(gameLevel.gameID, 0);
    }
    public Boolean isDead() {
        return level().isDead();
    }
 
}
