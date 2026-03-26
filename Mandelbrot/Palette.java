import java.util.ArrayList;
import java.util.HashSet;
import java.awt.*;
import java.awt.image.BufferedImage;
import javax.swing.JFrame;
import javax.swing.JPanel;

public class Palette {
    private ArrayList<Color> colors;
    private int size;

    Palette(ArrayList<Color> colors) {
        this.colors = colors;
        this.size = colors.size();
    }
    Palette() {
        this.colors = new ArrayList<Color>();
        this.size = 0;
    }

    @Override
    public String toString() {
        String str = "";
        str += "[R, G, B]\n";
        for (Color color : this.colors) {
            str += "[";
            str += color.getRed();
            str += ", ";
            str += color.getGreen();
            str += ", ";
            str += color.getBlue();
            str += "]";
            str += "\n";
        }
        return str;
    }

    public double[][] toArray() {
        double[][] arr = new double[this.getSize()][3];
        for (int i = 0; i < this.getSize(); i++) {
            arr[i][0] = this.getColor(i).getRed();
            arr[i][1] = this.getColor(i).getGreen();
            arr[i][2] = this.getColor(i).getBlue();
        }
        return arr;
    }

    public Color getColor(int index) {
        return colors.get(index);
    }
    public void setColor(int index, Color color) {
        colors.set(index, color);
    }
    public void addColor(Color color) {
        colors.add(color);
        size = colors.size();
    }
    public ArrayList<Color> getColorList() {
        return this.colors;
    }
    public int getSize() {
        return this.size;
    }
    public void removeColor(int index) {
        this.colors.remove(index);
        this.size = this.colors.size();
    }

    public void show() {
        int size_color = 50;  // 色の表示する大きさ，正方形の縦横の長さ
        int space = 10;  // 各色間の間隔
        int num_horizon = 16;  // 色の横方向の数
        int width = (size_color + space) * num_horizon;
        int height = num_horizon * size_color;

        JFrame frame = new JFrame("Palette");
        frame.setSize(width, height);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setLayout(new FlowLayout());

        JPanel[] panels = new JPanel[this.getSize()];
        for (int i = 0; i < this.getSize(); i++) {
            panels[i] = new JPanel();
            panels[i].setBackground(this.getColor(i));
            panels[i].setSize(size_color, size_color);
            frame.add(panels[i]);
        }

        frame.setVisible(true);
    }

    public void sort() {
        // Hの順にソート，昇順
        colors.sort( (a, b)->{
            float[] hsb_a = Color.RGBtoHSB(a.getRed(), a.getGreen(), a.getBlue(), null);
            float[] hsb_b = Color.RGBtoHSB(b.getRed(), b.getGreen(), b.getBlue(), null);
            if (hsb_a[0] > hsb_b[0]) return 1;
            else if (hsb_a[0] < hsb_b[0]) return -1;
            else return 0;
        });
    }

    public void reverse() {
        Palette copy = new Palette();
        for (int i = 0; i < this.getSize(); i++) {
            copy.addColor(this.getColor(i));
        }
        for (int i = 0; i < this.getSize(); i++) {
            this.setColor(i, copy.getColor(copy.getSize()-1 - i));
        }
    }

    public static Palette generateGradationH(int n, float Hmin, float Hmax, float S, float B) {
        Palette palette = new Palette();
        float df = (Hmax - Hmin) / n;
        for (float H = Hmin; H <= Hmax; H += df) {
            palette.addColor(new Color(Color.HSBtoRGB(H, S, B)));
        }
        if (palette.getSize() > n) {
            while (palette.getSize() != n) {
                palette.removeColor(palette.getSize() - 1);
            }
        } else {
            while (palette.getSize() != n) {
                palette.addColor(palette.getColor(palette.getSize() - 1));
            }
        }
        return palette;
    }

    public static Palette generateGradationS(int n, float H, float Smin, float Smax, float B) {
        Palette palette = new Palette();
        float df = (Smax - Smin) / n;
        for (float S = Smin; S <= Smax; S += df) {
            palette.addColor(new Color(Color.HSBtoRGB(H, S, B)));
        }
        if (palette.getSize() > n) {
            while (palette.getSize() != n) {
                palette.removeColor(palette.getSize() - 1);
            }
        } else {
            while (palette.getSize() != n) {
                palette.addColor(palette.getColor(palette.getSize() - 1));
            }
        }
        return palette;
    }

    public static Palette generateGradationB(int n, float H, float S, float Bmin, float Bmax) {
        Palette palette = new Palette();
        float df = (Bmax - Bmin) / n;
        for (float B = Bmin; B <= Bmax; B += df) {
            palette.addColor(new Color(Color.HSBtoRGB(H, S, B)));
        }
        if (palette.getSize() > n) {
            while (palette.getSize() != n) {
                palette.removeColor(palette.getSize() - 1);
            }
        } else {
            while (palette.getSize() != n) {
                palette.addColor(palette.getColor(palette.getSize() - 1));
            }
        }
        return palette;
    }

    public static Palette generateGrayScale(int n) {
        int step = (int) (256 / n);
        Palette palette = new Palette();
        for (int i = 0; i < n; i++) {
            palette.addColor(new Color(step*i, step*i, step*i));
        }
        palette.reverse();
        if (palette.getSize() > n) {
            while (palette.getSize() != n) {
                palette.removeColor(palette.getSize() - 1);
            }
        } else {
            while (palette.getSize() != n) {
                palette.addColor(palette.getColor(palette.getSize() - 1));
            }
        }
        return palette;
    }

    public static Palette extractFromImage(BufferedImage image) {
        Palette palette = new Palette();
        HashSet<Integer> uniqueColors = new HashSet<>();
        int width = image.getWidth();
        int height = image.getHeight();

        for (int x = 0; x < width; x++) {
            for (int y = 0; y < height; y++) {
                int rgb = image.getRGB(x, y);
                if (!uniqueColors.contains(rgb)) {
                    uniqueColors.add(rgb);
                    palette.addColor(new Color(rgb));
                }
            }
        }
        palette.sort();
        return palette;
    }

    public static Palette generateFromArray(double[][] arr) {
        Palette palette = new Palette();
        for (int i = 0; i < arr.length; i++) {
            palette.addColor(new Color((int) arr[i][0], (int) arr[i][1], (int) arr[i][2]));
        }
        return palette;
    }

    public Palette kmeans(int k) {
        double[][] palette_arr = this.toArray();
        double[][] reduced_arr = Kmeans.execute(palette_arr, k);
        Palette reduced_palette = Palette.generateFromArray(reduced_arr);
        return reduced_palette;
    }
}
