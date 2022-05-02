package com.rontap;

import java.awt.*;
import java.awt.geom.Point2D;

public class Circle extends Shape {

    public String getShapeName() { return  "CIRCLE"; };

    public Circle(Point2D center, int r) {
        super(center, r);
    }

    @Override
    public boolean isPointInArea(Point2D pt) {
        return pt.distance(center) < r;
    }
}
