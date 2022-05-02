package rontap.view;

import java.awt.Event;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import javax.swing.*;

import rontap.Main;
import rontap.model.Model;
import rontap.model.Size;

public class MenuBar extends JMenuBar {

    private Size size = Size.BASE;

    public MenuBar(Action startNewGameAction) {

        JMenu newGameMenu = new JMenu("New Game");

        JMenuItem startNewGame = new JMenuItem(startNewGameAction);
        startNewGame.setText("Start New");

        newGameMenu.add(startNewGame);

        newGameMenu.addSeparator();

        ButtonGroup group = new ButtonGroup();

        JRadioButtonMenuItem small = new JRadioButtonMenuItem();
        small.setText("Small - 2*2");
        ActionListener actionListener = new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String actionCommand = e.getActionCommand();
                size = Size.valueOf(actionCommand);
            }

        };
        small.addActionListener(actionListener);
        small.setActionCommand(Size.SMALL.name());
        group.add(small);

        JRadioButtonMenuItem base = new JRadioButtonMenuItem();
        base.setText("Normal - 3*3");
        base.setSelected(true);
        base.addActionListener(actionListener);
        base.setActionCommand(Size.BASE.name());
        group.add(base);

        JRadioButtonMenuItem medium = new JRadioButtonMenuItem();
        medium.setText("Medium 4*4");
        medium.addActionListener(actionListener);
        medium.setActionCommand(Size.MEDIUM.name());
        group.add(medium);

        JRadioButtonMenuItem large = new JRadioButtonMenuItem();
        large.setText("Large 6*6");
        large.addActionListener(actionListener);
        large.setActionCommand(Size.LARGE.name());
        group.add(large);

        newGameMenu.add(small);
        newGameMenu.add(base);
        newGameMenu.add(medium);
        newGameMenu.add(large);


        Action cheatModeAct = new AbstractAction() {
            @Override
            public void actionPerformed(ActionEvent e) {
                Main.CheatMode = !Main.CheatMode;
            }
        };
        JMenuItem cheatMode = new JMenuItem(cheatModeAct);
        cheatMode.setText(":)");

        newGameMenu.add(cheatMode);

        add(newGameMenu);
    }

    public Size getFieldSize() {
        return size;
    }
}
