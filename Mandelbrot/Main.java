public class Main {
    public static void main(String[] args) {
        int width_px = 780;
        int height_px = 1040;
        double re_target = -.5;
        double im_target = 0;
        double width_target = 2;
        double height_target = width_target * 4/3;
        Palette p = Palette.generateGrayScale(256);
        //p.reverse();
        Mandelbrot.setParams(width_px, height_px, re_target, im_target, width_target, height_target, p);
        Mandelbrot.save(Mandelbrot.generate(), "./images/", "", true);
    }
}
