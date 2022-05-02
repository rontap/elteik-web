package rontap.view;

import rontap.model.*;
import rontap.view.*;
import rontap.persistence.*;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.io.IOException;
import java.net.URL;
import java.util.logging.Level;
import java.util.logging.Logger;

public class MainWindow extends JFrame{
    
    private final int FPS = 40;
    private Game game;
    private Board board;
    private final JLabel gameStatLabel;    
    
    public Timer newFrameTimer;
    public Boolean paused = false;
    public int time;
    public final void initGame() throws IOException  {
        game = new Game();
        if (board == null) {
            board = new Board();
        }
        board.setGame(game);
        
        
        time = 0;
        newFrameTimer = new Timer(10000 / FPS, new NewFrameListener());
        newFrameTimer.setInitialDelay(1000);
        newFrameTimer.start();
        

    }
    public MainWindow() throws IOException{
 
      
        
        initGame();
        setTitle("Snek");
        setSize(600, 600);
        setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        URL url = MainWindow.class.getClassLoader().getResource("res/box.png");
        setIconImage(Toolkit.getDefaultToolkit().getImage(url));
        
        JMenuBar menuBar = new JMenuBar();
        JMenu menuGame = new JMenu("Game");
         JMenuItem menuGameLevel = new JMenuItem(new AbstractAction("New Game") {
            @Override
            public void actionPerformed(ActionEvent e) {
                System.out.println("NEW GAME");
                newFrameTimer.stop();
                try {
                    initGame();
                } catch (IOException ex) {
                    System.out.println(":(");
                }
            }
        });
        JMenu menuGameScale = new JMenu("Zoom Level");
        createScaleMenuItems(menuGameScale, 1.0, 2.0, 0.5);

        JMenuItem menuHighScores = new JMenuItem(new AbstractAction("Leaderboard") {
            @Override
            public void actionPerformed(ActionEvent e) {
                new HighScoreWindow(game.getHighScores(), MainWindow.this);
            }
        });
        
        JMenuItem menuGameExit = new JMenuItem(new AbstractAction("Exit Game") {
            @Override
            public void actionPerformed(ActionEvent e) {
                System.exit(0);
            }
        });

        menuGame.add(menuGameLevel);
        menuGame.add(menuGameScale);
        menuGame.add(menuHighScores);
        menuGame.addSeparator();
        menuGame.add(menuGameExit);
        menuBar.add(menuGame);
        setJMenuBar(menuBar);
        
        setLayout(new BorderLayout(0, 10));
        gameStatLabel = new JLabel("label");

        
        add(gameStatLabel, BorderLayout.NORTH);
        add( board  , BorderLayout.CENTER);

        addKeyListener(new KeyAdapter() {
            @Override
            public void keyPressed(KeyEvent ke) {
                super.keyPressed(ke); 
                Sneak sn = game.level().sneak;
                Boolean pauseAction = false;
                int kk = ke.getKeyCode();
                Direction d = null;
                switch (kk){
                    case KeyEvent.VK_LEFT:  d = Direction.LEFT; break;
                    case KeyEvent.VK_RIGHT: d = Direction.RIGHT; break;
                    case KeyEvent.VK_UP:    d = Direction.UP; break;
                    case KeyEvent.VK_DOWN:  d = Direction.DOWN; break;
                    case KeyEvent.VK_SPACE: pauseAction = true; 
                }
                
                if(pauseAction) {
                    paused = !paused;
                    if ( paused ) {
                        newFrameTimer.stop();
                    } else {
                        newFrameTimer.start();
                    }
                    
                }
              
               
                if (d != null) {
                      System.out.println(d.toString());
                    if ( ! Direction.opposite( sn.look ).equals(d)) {
                        sn.look = d;
                    }
                    tick(d); 
                }
               
              
            }
        });

        setResizable(false);
        setLocationRelativeTo(null);
      
        board.setScale(2.0); // board.refresh();
        pack();
        refreshGameStatLabel();
        setVisible(true);
    }
    private void tick(Direction d) {
        if (d == null) {
            game.level().update();
            time++;
        }
        refreshGameStatLabel();
        board.repaint();
                        
        if (game.isDead()) {
            System.out.println("GAME_DEAD");
            String inputValue = JOptionPane.showInputDialog("You Lost! Input Your name if you prefer:");
            newFrameTimer.stop();
            if (inputValue != null) {
                System.out.println("name given:: "+inputValue);
                game.database.storeToDatabase(inputValue, game.level().sneak.size() );
            }
        }
    }
    
    private void refreshGameStatLabel(){
        String s = "Snake Length: " + game.level().sneak.size();
        s += " Time Spent: " + (time);
        gameStatLabel.setText(s);
    }
    

    
    private void createScaleMenuItems(JMenu menu, double from, double to, double by){
        while (from <= to){
            final double scale = from;
            JMenuItem item = new JMenuItem(new AbstractAction(from + "x") {
                @Override
                public void actionPerformed(ActionEvent e) {
                    if (board.setScale(scale)) pack();
                }
            });
            menu.add(item);
            
            if (from == to) break;
            from += by;
            if (from > to) from = to;
        }
    }
    
    public static void main(String[] args) {
        try {
            new MainWindow();
        } catch (IOException ex) {}
    }  
    
     class NewFrameListener implements ActionListener {
          @Override
    public void actionPerformed(ActionEvent ae) {
              tick(null);
     }
     }
    
}
