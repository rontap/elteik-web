package rontap.view;

public class Button {
    public enum Type {
        UP, DOWN, LEFT, RIGHT, EMPTY, COLOR
    }

    public static String getLabel(Type type) {
        return switch (type) {
            case UP -> "↑";
            case DOWN -> "↓";
            case LEFT -> "←";
            case RIGHT -> "→";
            case EMPTY, COLOR -> "";
        };
    }

    public static Boolean getIsEnabled(Type type) {
        return switch (type) {
            case EMPTY, COLOR -> false;
            default -> true;
        };
    }

    public static Type getTypeOfCoords(int i, int j, int size) {
        size--;
        Button.Type type;
        if ((i == j && (i == 0 || i == size)) || ((i == 0 && j == size) || (j == 0 && i == size))) {
            type = Button.Type.EMPTY; // grid corners
        } else if (i == 0) {
            type = Button.Type.UP; // first row
        } else if (i == size) {
            type = Button.Type.DOWN; // last row
        } else if (j == 0) {
            type = Button.Type.LEFT; // first column
        } else if (j == size) {
            type = Button.Type.RIGHT; // last column
        } else {
            type = Button.Type.COLOR; // all we have left is the actual playfield
        }
        return type;
    }
}
