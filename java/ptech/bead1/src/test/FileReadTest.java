import com.rontap.Database;
import com.rontap.InvalidInputException;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;
import java.awt.geom.Point2D;
import java.io.FileNotFoundException;
import java.util.NoSuchElementException;

public class FileReadTest {
    private final Point2D pt =  new Point2D.Double(0, 0);

    @Test
    void testConstruct() {
        Database data = new Database(pt);
    }

    @Test
    void testEmptyFile() {
        Database data = new Database(pt);
        try {
            data.read("empty.txt");
            fail();
        } catch (FileNotFoundException | InvalidInputException e) {
            fail();
        } catch (NoSuchElementException e) {
        }
    }

    @Test
    void testNoFile() {
        Database data = new Database(pt);
        try {
            data.read("no.txt");
            fail();
        } catch (FileNotFoundException | InvalidInputException e) {
        } catch (NoSuchElementException e) {
            fail();
        }
    }

    @Test
    void testInvalidArgumentValue() {
        Database data = new Database(pt);
        try {
            data.read("invalidargs.txt");
            fail();
        } catch (FileNotFoundException | InvalidInputException e) {
            fail();
        } catch (NoSuchElementException e) {
        }
    }

    @Test
    void testInvalidArgumentLength() {
        Database data = new Database(pt);
        try {
            data.read("invalidlength.txt");
            fail();
        } catch (FileNotFoundException | InvalidInputException e) {
        } catch (NoSuchElementException e) {
            fail();
        }
    }

    @Test
    void testInvalidType() {
        Database data = new Database(pt);
        try {
            data.read("invalidtype.txt");
            fail();
        } catch (FileNotFoundException | InvalidInputException e) {
        } catch (NoSuchElementException e) {
            fail();
        }
    }

}
