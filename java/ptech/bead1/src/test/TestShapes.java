import com.rontap.Database;
import com.rontap.InvalidInputException;
import org.junit.jupiter.api.Test;

import java.awt.geom.Point2D;
import java.io.FileNotFoundException;
import java.util.Arrays;
import java.util.NoSuchElementException;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.fail;

public class TestShapes {
    private final Point2D pt = new Point2D.Double(0, 0);

    @Test
    void allShapesFit() {
        Database data = new Database(pt);
        try {
            data.read("allshapes.txt");
            assertEquals(data.boolReport(), Arrays.asList(true, true, true, true, true));
        } catch (FileNotFoundException | InvalidInputException e) {
            e.printStackTrace();
        }
    }

    @Test
    void allShapesUnfit() {
        Database data = new Database(pt);
        try {
            data.read("allshapesbad.txt");
            assertEquals(data.boolReport(), Arrays.asList(false, false, false, false, false));
        } catch (FileNotFoundException | InvalidInputException e) {
            e.printStackTrace();
        }
    }

    @Test
    void allShapesFitShifted() {
        Database data = new Database(pt);
        try {
            data.read("allshapesshifted.txt");
            assertEquals(data.boolReport(), Arrays.asList(true, true, true, true, true));
        } catch (FileNotFoundException | InvalidInputException e) {
            e.printStackTrace();
        }
    }

    @Test
    void squareEdgecases() {
        Database data = new Database(pt);
        try {
            data.read("sq.txt");
            assertEquals(data.boolReport(), Arrays.asList(true, true, true, true, true, true,  false, false, false, false, false, true));
        } catch (FileNotFoundException | InvalidInputException e) {
            e.printStackTrace();
        }
    }

    @Test
    void circleEdgecases() {
        Database data = new Database(pt);
        try {
            data.read("cc.txt");
            assertEquals(data.boolReport(), Arrays.asList(false, false, false, false, false, false, false, false));
        } catch (FileNotFoundException | InvalidInputException e) {
            e.printStackTrace();
        }
    }


    @Test
    void complexUseCase() {
        Database data = new Database(pt);
        try {
            data.read("cplx.txt");
            assertEquals(data.boolReport(), Arrays.asList(true, true, true, false, true, true, false));
        } catch (FileNotFoundException | InvalidInputException e) {
            e.printStackTrace();
        }
    }

}
