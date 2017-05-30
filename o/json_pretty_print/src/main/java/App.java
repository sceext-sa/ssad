import java.io.File;
import java.io.FileInputStream;

import mjson.Json;
import org.sceext.JsonPretty;


public class App {
    private static String _read_file(String filename) throws Exception {
        File f = new File(filename);
        long file_size = f.length();
        FileInputStream s = new FileInputStream(f);
        // DEBUG
        System.err.println("D: read file `" + filename + "`, size = " + file_size);

        byte[] b = new byte[(int)file_size];
        s.read(b);
        // convert to string
        return new String(b, "utf-8");
    }

    private static void _main(String filename) throws Exception {
        String raw_json = _read_file(filename);
        // parse json text
        Json j = Json.read(raw_json);
        // print with Json lib
        System.out.println("DEBUG: print with Json lib: ");
        System.out.println(j.toString());
        // print with pretty_print
        System.out.println("DEBUG: pretty-print json: ");
        String pretty = JsonPretty.print(j);
        System.out.println(pretty);

        // parse that json and check it with Json lib
        Json j2 = Json.read(pretty);
        System.out.println("DEBUG: check pretty-print, result = " + j.equals(j2));
    }

    public static void main(String[] args) {
        try {
            _main(args[0]);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
