package rontap.view;

import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.net.URL;
import java.util.Arrays;
import javax.swing.*;

import rontap.model.Size;
import rontap.model.Model;

public class MainWindow extends JFrame {

    private Model model;
    private final MenuBar menuBar;
    private JButton[][] grid;

    private final static java.util.List<String> colors = Arrays.asList("#F44336", "#4CAF50", "#03A9F4", "#9C27B0", "#ffffff", "#000000");

    JPanel mainPanel = new JPanel();

    public void initGrid(Size size) {

        mainPanel.removeAll();

        this.model = new Model(size);
        this.grid = new JButton[model.getTableSize()][model.getTableSize()];

        mainPanel.setLayout(new GridLayout(model.getTableSize(), model.getTableSize()));

        for (int i = 0; i < model.getTableSize(); ++i) {
            for (int j = 0; j < model.getTableSize(); ++j) {
                addButton(mainPanel, i, j, Button.getTypeOfCoords(i, j, model.getTableSize()));
            }
        }
        add(mainPanel, BorderLayout.CENTER);
        revalidate();
        repaint();
    }

    public MainWindow() {
        setTitle("Rubik 2D");
        setSize(400, 450);

        URL url = MainWindow.class.getResource("icon.png");
        setIconImage(Toolkit.getDefaultToolkit().getImage(url));

        addWindowListener(new WindowAdapter() {
            @Override
            public void windowClosing(WindowEvent e) {
                showExitConfirmation();
            }
        });

        setDefaultCloseOperation(DO_NOTHING_ON_CLOSE);
        initGrid(Size.MEDIUM);

        setLayout(new BorderLayout());
        add(mainPanel, BorderLayout.CENTER);

        Action startNewGameAction = new AbstractAction() {
            @Override
            public void actionPerformed(ActionEvent e) {
                Size size = menuBar.getFieldSize();
                model = new Model(size);
                initGrid(size);
                renderButtons();
            }
        };
        menuBar = new MenuBar(startNewGameAction);

        setJMenuBar(menuBar);
    }

    private void setGridBackground(int i, int j) {
        grid[i][j].setBackground(Color.decode(MainWindow.colors.get(model.getTableLoc(i, j))));
    }

    private void renderButtons() {
        for (int i = 1; i < grid.length - 1; i++) {
            for (int j = 1; j < grid[0].length - 1; j++) {
                //System.out.println(grid[0].length+"-"+i+"--"+j);
                setGridBackground(i, j);
            }
        }
    }

    private void addButton(JPanel mainPanel, int i, int j, Button.Type type) {
        grid[i][j] = new JButton();
        grid[i][j].setText(Button.getLabel(type));
        grid[i][j].setEnabled(Button.getIsEnabled(type));

        if (type == Button.Type.COLOR) {
            setGridBackground(i, j);
        }

        mainPanel.add(grid[i][j]);

        grid[i][j].addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent e) {
                if (model == null) return;

                switch (e.getButton()) {
                    case MouseEvent.BUTTON1 -> {
                        Button.Type type = Button.getTypeOfCoords(i, j, model.getTableSize());
                        model.shift(type, i - 1, j - 1);
                        renderButtons();

                        if (model.isFinished()) {
                            int n = JOptionPane.showConfirmDialog(MainWindow.this,
                                    "You win!\nIt took " + model.getSteps() + " steps to complete this 2D Puzzle.\nDo you want to start a new game?",
                                    "Congratulations!", JOptionPane.YES_NO_OPTION);
                            if (n == JOptionPane.YES_OPTION) {
                                Size size = menuBar.getFieldSize();
                                model = new Model(size);
                                initGrid(size);
                            }

                        }

                    }
                    case MouseEvent.BUTTON3 -> {
                        System.out.println("btn3");
                    }
                }
            }
        });
    }

    private void showExitConfirmation() {
        int n = JOptionPane.showConfirmDialog(this,
                "Do you want to exit?",
                "Confirm", JOptionPane.YES_NO_OPTION);
        if (n == JOptionPane.YES_OPTION) {
            System.exit(0);
        }
    }

}
