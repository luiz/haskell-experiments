import java.io.*;

public class Sum2 {
	public static void main(String[] args) throws IOException {
		long sum = 0;
		try (BufferedReader reader = new BufferedReader(new InputStreamReader(System.in))) {
			String line = null;
			while ((line = reader.readLine()) != null) {
				sum += Integer.parseInt(line);
			}
		} finally {
			System.out.println(sum);
		}
	}
}
