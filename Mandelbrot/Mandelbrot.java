import java.util.Scanner;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;
import java.awt.Color;
import java.awt.image.BufferedImage;
import javax.imageio.ImageIO;

public class Mandelbrot {

    private static int width_px, height_px;
    private static double re_target, im_target, width_target, height_target;
    private static Palette palette;

    private static double reMin;
    private static double reMax;
    private static double imMin;
    private static double imMax;
    private static final int mandelCountMax = 300;

    public static void setParams(int width_px, int height_px, double re_target, double im_target, double width_target, double height_target, Palette palette) {
        Mandelbrot.width_px = width_px;
        Mandelbrot.height_px = height_px;
        Mandelbrot.re_target = re_target;
        Mandelbrot.im_target = im_target;
        Mandelbrot.width_target = width_target;
        Mandelbrot.height_target = height_target;
        Mandelbrot.palette = palette;

        reMin = Mandelbrot.re_target - Mandelbrot.width_target/2;
        reMax = Mandelbrot.re_target + Mandelbrot.width_target/2;
        imMin = Mandelbrot.im_target - Mandelbrot.height_target/2;
        imMax = Mandelbrot.im_target + Mandelbrot.height_target/2;
    }

    // x,yを複素数に変換するstatic method
    public static Complex getComplexAt(int x, int y) {
        double xd = (double) x;
        double yd = (double) y;
        double re_r = (xd/width_px)*reMax + (1 - xd/width_px)*reMin;
        double im_r = (yd/height_px)*imMin + (1 - yd/height_px)*imMax;
        return new Complex(re_r, im_r);
    }

    // abs(z)が初めて2を超えるnを計算する
    public static int mandelCount(Complex c) {
        int n;
        Complex z = new Complex(0, 0);

        for (n = 1; n <= mandelCountMax; n++) {

            z = z.powi(2).plus(c);  // z_n+1 = z_n + c

            if (z.abs() > 2) {
                break;
            }
        }
        return n;
    }

    // mandelCountの結果nから⾊を決めるstatic method
    public static Color nToColor(int n, Palette palette) {
        int step = (int) Mandelbrot.mandelCountMax / palette.getSize();
        int left = 0;
        for (int i = 0; i < palette.getSize(); i++) {
            if (left+step*i <= n && n <= left+step*(i+1)) {
                return palette.getColor(i);
            }
        }
        return palette.getColor(palette.getSize()-1);
    }

    // make Mnadelbrot "Mandelbrot(args).makeMandel();"
    public static BufferedImage generate() {
        var image = new BufferedImage(width_px, height_px, BufferedImage.TYPE_INT_ARGB);

        // 位置(x, y)の色を決め，描画する
        Complex z;
        int n;
        Color c;
        for (int x = 0; x < width_px; x++) {
            for (int y = 0; y < height_px; y++) {
                z = Mandelbrot.getComplexAt(x, y);
                n = Mandelbrot.mandelCount(z);
                c = Mandelbrot.nToColor(n, palette);
                image.setRGB(x, y, c.getRGB());
            }
        }

        return image;
    }

    public static void save(BufferedImage image, String directory, String title, boolean overwrite) {
        String filepath;
        if (title.equals("")) {
            filepath = directory + "mandelbrot" + height_px + "x" +width_px + ".png";
        } else {
            filepath = directory + title + ".png";
        }
        Path path = Paths.get(filepath);

        if ((Files.exists(path) && overwrite) ||  !Files.exists(path)) {
            File file = new File(filepath);
            try{
                ImageIO.write(image, "png", file);
            }catch(Exception e){
                System.out.println(e);
            };
        } else {
            System.out.println("file exists & force is false. File NOT saved.");
            return;
        }
    }

    public static void export(String directory, String title, boolean overwrite) {
        String filepath;
        if (title.equals("")) {
            filepath = directory + "no_title.txt";
        } else {
            filepath = directory + title + ".txt";
        }
        Path path = Paths.get(filepath);

        if ((Files.exists(path) && overwrite) ||  !Files.exists(path)) {
            try (BufferedWriter writer = Files.newBufferedWriter(path, 
                                                                StandardCharsets.UTF_8, 
                                                                StandardOpenOption.CREATE, 
                                                                StandardOpenOption.TRUNCATE_EXISTING)) {
                writer.write(String.valueOf(width_px)); writer.newLine();
                writer.write(String.valueOf(height_px)); writer.newLine();
                writer.write(String.valueOf(re_target)); writer.newLine();
                writer.write(String.valueOf(im_target)); writer.newLine();
                writer.write(String.valueOf(width_target)); writer.newLine();
                writer.write(String.valueOf(height_target)); writer.newLine();
                writer.write(String.valueOf(palette.getSize())); writer.newLine();
                for (Color color: palette.getColorList()) {
                    writer.write(String.valueOf(color.getRed())); writer.write(",");
                    writer.write(String.valueOf(color.getGreen())); writer.write(",");
                    writer.write(String.valueOf(color.getBlue())); writer.write(",");
                    writer.newLine();
                }
            }catch(Exception e){
                System.out.println(e);
            };
        } else {
            System.out.println("file exists & force is false. File NOT exported.");
            return;
        }
    }

    public static void read(String path) {
        File file = new File(path);
        int wpx, hpx;
        double ret, imt, wt, ht;
        Palette p;
        int n;
        double[][] list;

        try (Scanner scanner = new Scanner(file)) {
            wpx = Integer.parseInt(scanner.nextLine());
            hpx = Integer.parseInt(scanner.nextLine());
            ret = Double.parseDouble(scanner.nextLine());
            imt = Double.parseDouble(scanner.nextLine());
            wt = Double.parseDouble(scanner.nextLine());
            ht = Double.parseDouble(scanner.nextLine());
            n = Integer.parseInt(scanner.nextLine());
            list = new double[n][3];
            scanner.useDelimiter(",");
            String r, g, b;
            for (int i = 0; i < n; i++) {
                r = scanner.next(); g = scanner.next(); b = scanner.next();
                list[i][0] = Double.parseDouble(r.trim());
                list[i][1] = Double.parseDouble(g.trim());
                list[i][2] = Double.parseDouble(b.trim());
            }
            p = Palette.generateFromArray(list);
            Mandelbrot.setParams(wpx, hpx, ret, imt, wt, ht, p);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
    }
}
