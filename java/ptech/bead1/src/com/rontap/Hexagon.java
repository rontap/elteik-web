package com.rontap;

import java.awt.*;
import java.awt.geom.Point2D;

public class Hexagon extends RegularShape {
    public String getShapeName() { return  "HEXAGON"; };

    public Hexagon(Point2D center, int side_length) {
        super(center, side_length, 6);
    }
}
