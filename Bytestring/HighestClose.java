import java.util.regex.*;
import java.util.*;
import java.io.*;

public class HighestClose {
    public static int closing(String csvLine) {
        return readPrice(csvLine.split(",")[4]);
    }

    public static int readPrice(String number) {
        Pattern p = Pattern.compile("(\\d+)\\.(\\d{2})");
        Matcher m = p.matcher(number);
        if (m.matches()) {
            int dollars = Integer.valueOf(m.group(1));
            int cents = Integer.valueOf(m.group(2));
            return dollars * 100 + cents;
        }
        return 0;
    }

    public static int highestClose(String wholeFile) {
        String[] lines = wholeFile.split("\n");
        int max = 0;
        for (String line : lines) {
            int thisClosing = closing(line);
            if (thisClosing > max) {
                max = thisClosing;
            }
        }
        return max;
    }

    public static void main(String args[]) throws FileNotFoundException {
        try (Scanner sc = new Scanner(new File(args[0])).useDelimiter("$$")) {
            System.out.println(highestClose(sc.next()));
        }
    }
}
