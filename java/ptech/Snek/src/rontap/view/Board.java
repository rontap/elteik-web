package rontap.view;

import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Image;
import java.io.IOException;
import java.util.ArrayList;
import javax.swing.JPanel;
import rontap.model.Game;
import rontap.model.Position;
import rontap.model.Sneak;
import rontap.model.Stone;
import rontap.res.ResourceLoader;

public class Board extends JPanel {
    private Game game;
    private final Image  snek_fr, reward,  stone, empty,snek_tl,snek_mn;
    private double scale;
    private int scaled_size;
    private final int tile_size = 18;
    
    public Board() throws IOException{
        scale = 1.0;
        scaled_size = (int)(scale * tile_size);
        snek_tl = ResourceLoader.loadImage("res/snek_tl.png");
        snek_mn = ResourceLoader.loadImage("res/snek.png");
        snek_fr = ResourceLoader.loadImage("res/snek_fr.png");
        reward = ResourceLoader.loadImage("res/reward.png");
        stone = ResourceLoader.loadImage("res/wall.png");
        empty = ResourceLoader.loadImage("res/empty.png");
    }
    public void setGame(Game g) {
        game =g;
    }
    
    public boolean setScale(double scale){
        this.scale = scale;
        scaled_size = (int)(scale * tile_size);
        return refresh();
    }
    
    public boolean refresh(){
        if (!game.isLevelLoaded()) return false;
        Dimension dim = new Dimension(game.getLevelCols() * scaled_size, game.getLevelRows() * scaled_size);
        setPreferredSize(dim);
        setMaximumSize(dim);
        setSize(dim);
        repaint();
        return true;
    }
    
    @Override
    protected void paintComponent(Graphics g) {
        if (!game.isLevelLoaded()) return;
        Graphics2D gr = (Graphics2D)g;
        int w = game.getLevelCols();
        int h = game.getLevelRows();
       // Position p = game.getPlayerPos();
        for (int y = 0; y < h; y++){
            for (int x = 0; x < w; x++){
                gr.drawImage(empty, x * scaled_size, y * scaled_size, scaled_size, scaled_size, null);
            }
        }
        
        // REWARD
        gr.drawImage(reward, game.level().reward.x() * scaled_size,  game.level().reward.y() * scaled_size, scaled_size, scaled_size, null);
  
        
        /// SNEAK
        Sneak sn = game.level().sneak;
        for (int i = 0; i < sn.size() ;i++ ) {
            Image img = null;
            if ( i == 0 ) img = snek_tl;
            else if ( i == sn.size()-1 ) img = snek_fr;
            else img = snek_mn;
            gr.drawImage(img, sn.snek.get(i).x * scaled_size,  sn.snek.get(i).y * scaled_size, scaled_size, scaled_size, null);
        }
            
        ArrayList<Stone> st = game.level().stones;
        for (int i = 0; i < st.size() ;i++ ) {
            Image img = stone;

            gr.drawImage(img, st.get(i).x() * scaled_size,  st.get(i).y() * scaled_size, scaled_size, scaled_size, null);
        }
    }
    
}
