package rontap.model;

import rontap.Main;
import rontap.view.Button;

import java.util.*;

public class Model {

    private final Size size;
    private int steps;
    private final int[][] table;

    public Model(Size size) {
        this.size = size;
        this.table = new int[getDim()][getDim()];
        this.steps = 0;
        generateField();
    }

    public int getDim() {
        return switch (size) {
            case SMALL -> 2;
            case BASE -> 3;
            case MEDIUM -> 4;
            case LARGE -> 6;
        };
    }

    public int getTableSize() {
        return this.getDim() + 2;
    }

    public void generateField() {
        int size = getDim();
        int[] flatInt = new int[size * size];
        Arrays.setAll(flatInt, i -> (i % size));
        if (!Main.CheatMode) flatInt = shuffle(flatInt);

        for (int i = 0; i < table.length; i++) {
            System.arraycopy(flatInt, i * table.length, table[i], 0, table[0].length);
        }
    }

    public void shift(Button.Type dir, int id, int jd) {
        int dim = getDim() - 1;
        if (dir == Button.Type.LEFT) {
            int temp = table[id][0];
            for (int i = 0; i < dim; i++) {
                table[id][i] = table[id][i + 1];
            }
            table[id][dim] = temp;
        } else if (dir == Button.Type.RIGHT) {
            int temp = table[id][dim];
            for (int i = dim; i > 0; i--) {
                table[id][i] = table[id][i - 1];
            }
            table[id][0] = temp;
        } else if (dir == Button.Type.UP) {
            int temp = table[0][jd];
            for (int i = 0; i < dim; i++) {
                table[i][jd] = table[i + 1][jd];
            }
            table[dim][jd] = temp;
        } else if (dir == Button.Type.DOWN) {
            int temp = table[dim][jd];
            for (int i = dim; i > 0; i--) {
                table[i][jd] = table[i - 1][jd];
            }
            table[0][jd] = temp;
        }
        steps++;
        System.out.println(id + "_" + jd + "_" + dir.toString() + "finishe:" + isFinished());
    }

    public int getSteps() {
        return steps;
    }

    public Boolean isFinished() {
        int dim = getDim();
        boolean finished = true;
        //lines match
        for (int i = 0; i < dim; i++) {
            int fElem = table[i][0];
            for (int j = 0; j < dim; j++) {
                if (table[i][j] != fElem) {
                    finished = false;
                    break;
                }
            }
        }
        if (finished) return true;
        finished = true;
        // rows match
        for (int i = 0; i < dim; i++) {
            int fElem = table[0][i];
            for (int j = 0; j < dim; j++) {
                if (table[j][i] != fElem) {
                    finished = false;
                    break;
                }
            }
        }
        return finished;
    }

    public int[] shuffle(int[] array) {
        Random rnd = new Random();
        for (int i = array.length - 1; i > 0; i--) {
            int index = rnd.nextInt(i + 1);
            int a = array[index];
            array[index] = array[i];
            array[i] = a;
        }
        return array;
    }

    public Size getSize() {
        return size;
    }

    public int getTableLoc(int row, int column) {
        return table[row - 1][column - 1];
    }
}
