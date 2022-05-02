package com.rontap;

import java.awt.*;
import java.awt.geom.Point2D;

public class Triangle extends RegularShape {
    public String getShapeName() { return  "TRIANGLE"; };

    public Triangle(Point2D center, int side_length) {
        super(center, side_length, 3);
    }
}
