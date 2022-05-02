package com.rontap;


import java.awt.*;
import java.awt.geom.Point2D;
import java.io.FileNotFoundException;
import java.util.InputMismatchException;
import java.util.NoSuchElementException;

public class Main {

    public static void main(String[] args) {
        process("data.sc");
    }

    public static void process(String fileName) {
        System.out.println("Loading Scenario: "+fileName);

        Database data = new Database(new Point2D.Double(10,2));
        try {
            data.read("data.txt");
        } catch (FileNotFoundException ex) {
            System.out.println("Error : File not found!");
            System.exit(-1);
        } catch (InvalidInputException ex) {
            System.out.println("Error : Invalid shape type. Use 0 for circle, and 3,4,5,6 for polygons!");
            System.exit(-2);
        } catch (InputMismatchException ex) {
            System.out.println("Error : Invalid input type. should be integer");
            System.exit(-3);
        } catch (NoSuchElementException ex) {
            System.out.println("Error: Invalid number of arguments. should be [SHAPE] [X] [Y] [R]");
            System.exit(-4);
        }
        data.report();
    }




}

