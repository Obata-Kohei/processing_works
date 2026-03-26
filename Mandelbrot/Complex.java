public class Complex {
    private double re;
    private double im;

    Complex(double re, double im) {
        this.re = re;
        this.im = im;
    }

    public double getRe() {
        return re;
    }
    public double getIm() {
        return im;
    }
    public void setRe(double re) {
        this.re = re;
    }
    public void setIm(double im) {
        this.im = im;
    }
    public void setComplex(double re, double im) {
        this.re = re;
        this.im = im;
    }

    public String toString() {
        return String.format("(%f, %f)", this.re, this.im);
    }

    public double abs() {
        return Math.sqrt(Math.pow(this.re, 2) + Math.pow(this.im, 2));
    }

    public Complex plus(Complex other) {
        return new Complex(this.re + other.re, this.im + other.im);
    }

    public Complex minus(Complex other) {
        return new Complex(this.re - other.re, this.im - other.im);
    }

    public Complex mul(Complex other) {
        return new Complex(this.re * other.re - this.im * other.im, this.re * other.im + this.im * other.re);
    }

    public Complex div(Complex other) {
        return new Complex((this.re*other.re + this.im*other.im) / Math.pow(other.abs(), 2), (this.im*other.re - this.re*other.im) / Math.pow(other.abs(), 2));
    }

    public Complex powi(int n) {
        Complex z = this;
        for (int i = 0; i < n-1; i++) {
            z = z.mul(this);
        }
        return z;
    }

    public Complex powf(double a) {
        double r = this.abs();
        double theta = Math.atan(this.im / this.re);
        double r_pow = Math.pow(r, a);
        double theta_pow = theta * a;
        return new Complex(r_pow * Math.cos(theta_pow), r_pow * Math.sin(theta_pow));
    }

    public static Complex exp(Complex z) {
        double re = Math.exp(z.re) * Math.cos(z.im);
        double im = Math.exp(z.im) * Math.sin(z.im);
        return new Complex(re, im);
    }
}
