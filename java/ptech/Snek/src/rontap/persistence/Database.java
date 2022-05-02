package rontap.persistence;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import rontap.model.GameID;

public class Database {
    private final String tableName = "sokoban.score";
    private final Connection conn;
    private final HashMap<String, Integer> highScores;
    
    public Database(){
        Connection c = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            c = DriverManager.getConnection("jdbc:mysql://localhost/sokoban?"
                    + "serverTimezone=UTC&user=student&password=asd123");
        } catch (Exception ex) {
            System.out.println("!!!! No connection !!! ");
        }
        this.conn = c;
        highScores = new HashMap<>();
        loadHighScores();
    }
    
    public boolean storeHighScore(String id, int newScore){
        return mergeHighScores(id, newScore, newScore > 0);
    }
    
    public ArrayList<HighScore> getHighScores(){
        ArrayList<HighScore> scores = new ArrayList<>();
        for (String id : highScores.keySet()){
            HighScore h = new HighScore(id, highScores.get(id));
            scores.add(h);
            System.out.println(h);
        }
        return scores;
    }
    
    private void loadHighScores(){
        try (Statement stmt = conn.createStatement()) {
            ResultSet rs = stmt.executeQuery("SELECT * FROM sokoban.score ORDER BY score DESC LIMIT 10");
            while (rs.next()){
                String name = rs.getString("name");
                int score = rs.getInt("score");
                highScores.put(name, score);
            }
        } catch (Exception e){ System.out.println("loadHighScores error: " + e.getMessage());}
    }
    
    private boolean mergeHighScores(String id, int score, boolean store){
        return true;
    }
    
    public int storeToDatabase(String id, int score){
        System.out.println("SAVE_TO_SYSTEM");
        try (Statement stmt = conn.createStatement()){
            String s = "INSERT INTO sokoban.score" + 
                    " (idscore, name, score) " + 
                    "VALUES( 0 ,'" + id + "'," + score + 
                    ")";
            stmt.executeUpdate(s);
            loadHighScores();
        } catch (Exception e){
            System.out.println(e);
            System.out.println("storeToDatabase error");
        }
        
        return 0;
    }
    
}
