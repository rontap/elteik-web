package com.rontap;

import java.awt.geom.Point2D;
import java.util.ArrayList;

public abstract class RegularShape extends Shape {
    protected ArrayList<Point2D> edges;
    private static double ACCURACY = 1000;

    protected int sides;

    public RegularShape(Point2D center, int side_length, int sides) {
        super(center, side_length);

        this.sides = sides;
        edges = generatePoints(sides);

        System.out.println("sides::" + sides + " edges::" + edges);
    }

    @Override
    public boolean isPointInArea(Point2D p) {
        boolean result = false;
        int j = edges.size() - 1;
        for (int i = 0; i < edges.size(); i++) {
            if (edges.get(i).getY() < p.getY() && edges.get(j).getY() >= p.getY() || edges.get(j).getY() < p.getY() && edges.get(i).getY() >= p.getY()) {
                if (edges.get(i).getX() + (p.getY() - edges.get(i).getY()) / (edges.get(j).getY() - edges.get(i).getY()) * (edges.get(j).getX() - edges.get(i).getX()) < p.getX()) {
                    result = !result;
                }
            }
            j = i;
        }
        return result;
    }


    public ArrayList<Point2D> getEdges() {
        return edges;
    }

    public int getSideLength() {
        return getR();
    }

    public Boolean isOdd() {
        return sides % 2 == 0;
    }

    public double getAngle() {
        return 2 * Math.PI / sides;
    }

    private ArrayList<Point2D> generatePoints(int sides) {
        double startAngle = (isOdd() ? Math.PI - getAngle() : Math.PI) / 2;
        ArrayList<Point2D> list = new ArrayList<>();

        for (int i = 0; i < sides; i++) {
            double currentAngle = startAngle + i * getAngle();
            double x = Math.round((center.getX() + (r * Math.cos(currentAngle))) * ACCURACY) / ACCURACY;
            double y = Math.round((center.getY() + (r * Math.sin(currentAngle))) * ACCURACY) / ACCURACY;
            list.add(new Point2D.Double(x, y));
        }
        return list;
    }

}
