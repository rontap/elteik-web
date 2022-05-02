package com.rontap;

import java.awt.*;
import java.awt.geom.Point2D;
import java.util.Map;

public abstract class Shape {
    public Shape(Point2D center, int r) {
        this.center = center;
        this.r = r;
    }

    public String getShapeName() { return  ""; };

    protected Point2D center;
    protected int r;

    public Point2D getCenter() {
        return center;
    }

    public int getR() {
        return r;
    }

    public boolean isPointInArea(Point2D p) {
        return false;
    }

    @Override
    public String toString() {
        return getShapeName() + " | center: " + getCenter() + " | rad: " + getR();
    }

}
