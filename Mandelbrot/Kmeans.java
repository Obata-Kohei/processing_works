import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class Kmeans {

    public static double[][] execute(double[][] data, int k) {
        int n = data[0].length; // 次元数
        int numPoints = data.length;
        Random random = new Random();

        // 初期のクラスタ中心をランダムに選択
        double[][] centroids = new double[k][n];
        for (int i = 0; i < k; i++) {
            int randomIndex = random.nextInt(numPoints);
            centroids[i] = data[randomIndex];
        }

        boolean change = true;
        while (change) {
            change = false;

            // 各データ点を最も近いクラスタに割り当て
            List<List<double[]>> clusters = new ArrayList<>();
            for (int i = 0; i < k; i++) {
                clusters.add(new ArrayList<>());
            }

            int[] assignments = new int[numPoints];
            for (int i = 0; i < numPoints; i++) {
                int nearestIndex = 0;
                double nearestDistance = Double.MAX_VALUE;
                for (int j = 0; j < k; j++) {
                    double distance = euclideanDistance(data[i], centroids[j]);
                    if (distance < nearestDistance) {
                        nearestDistance = distance;
                        nearestIndex = j;
                    }
                }
                assignments[i] = nearestIndex;
                clusters.get(nearestIndex).add(data[i]);
            }

            // 新しいクラスタ中心を計算
            for (int i = 0; i < k; i++) {
                double[] newCentroid = calculateCentroid(clusters.get(i));
                if (!equals(centroids[i], newCentroid)) {
                    centroids[i] = newCentroid;
                    change = true;
                }
            }
        }

        return centroids;
    }

    private static double euclideanDistance(double[] point1, double[] point2) {
        double sum = 0.0;
        for (int i = 0; i < point1.length; i++) {
            double diff = point1[i] - point2[i];
            sum += diff * diff;
        }
        return Math.sqrt(sum);
    }

    private static double[] calculateCentroid(List<double[]> cluster) {
        int dimensions = cluster.get(0).length;
        double[] centroid = new double[dimensions];
        for (double[] point : cluster) {
            for (int i = 0; i < dimensions; i++) {
                centroid[i] += point[i];
            }
        }
        int size = cluster.size();
        for (int i = 0; i < dimensions; i++) {
            centroid[i] /= size;
        }
        return centroid;
    }

    private static boolean equals(double[] v1, double[] v2) {
        for (int i = 0; i < v1.length; i++) {
            if (v1[i] != v2[i]) {
                return false;
            }
        }
        return true;
    }
}
