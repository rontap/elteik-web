package com.rontap;

import java.awt.*;
import java.awt.geom.Point2D;

public class Square extends RegularShape {
    public String getShapeName() { return  "SQUARE"; };

    public Square(Point2D center, int side_length) {
        super(center, side_length, 4);
    }
}
