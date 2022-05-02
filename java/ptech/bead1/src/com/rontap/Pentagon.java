package com.rontap;

import java.awt.*;
import java.awt.geom.Point2D;

public class Pentagon extends RegularShape {
    public String getShapeName() { return  "PENTAGON"; };

    public Pentagon(Point2D center, int side_length) {
        super(center, side_length, 5);
    }
}
