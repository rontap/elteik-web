package com.rontap;


import java.awt.geom.Point2D;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.InputMismatchException;
import java.util.NoSuchElementException;
import java.util.Scanner;

/**
 * @author pinter
 */
public class Database {

    private final ArrayList<Shape> shapes;
    private final Point2D p;

    public Database(Point2D p) {
        this.p = p;
        shapes = new ArrayList<>();
    }

    public void read(String filename) throws FileNotFoundException, InvalidInputException, NoSuchElementException {

        Scanner sc = new Scanner(new BufferedReader(new FileReader("files/" + filename)));
        int numObjs = sc.nextInt(); // not used I guess
        while (sc.hasNext()) {
            int type = sc.nextInt();
            Point2D center = new Point2D.Double(sc.nextInt(), sc.nextInt());
            int r = sc.nextInt();

            shapes.add(shapeRouter(type, center, r));

        }
    }

    public Shape shapeRouter(int type, Point2D center, int r) throws InvalidInputException {
        return switch (type) {
            case 0 -> new Circle(center, r);
            case 3 -> new Triangle(center, r);
            case 4 -> new Square(center, r);
            case 5 -> new Pentagon(center, r);
            case 6 -> new Hexagon(center, r);
            default -> throw new InvalidInputException();
        };
    }

    public void report() {
        System.out.println("== SHAPES == size: " + shapes.size());
        int count = 0;
        for (Shape shp : shapes) {
            System.out.println(shp);
            if (shp.isPointInArea(p)) count++;
        }


        shapes.forEach((shp) -> System.out.println(" | " + shp.getShapeName() + "== IsPointInArea ==" + shp.isPointInArea(p)));

        System.out.println(" === All in all, there are " + count + " shapes that have " + p + " inside.");
    }

    public ArrayList<Boolean> boolReport() {
        ArrayList<Boolean> al = new ArrayList<>();
        shapes.forEach((shp) -> al.add(shp.isPointInArea(p)));
        return al;
    }


    public void clear() {
        shapes.clear();
    }

}
