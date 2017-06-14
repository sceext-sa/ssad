package org.sceext.ssad_server;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;

import mjson.Json;


public class Util {
    // for file write-replace
    public static String TMP_SUFFIX = ".tmp";

    public static void write_text_file(String file_path, String text) throws Exception {
        byte[] data = text.getBytes("utf-8");
        FileOutputStream s = new FileOutputStream(file_path);
        s.write(data);
        s.flush();
        s.close();
    }

    public static void write_replace(String file_path, String text) throws Exception {
        String tmp_file = file_path + TMP_SUFFIX;
        write_text_file(tmp_file, text);

        File tmp = new File(tmp_file);
        File to = new File(file_path);
        if (! tmp.renameTo(to)) {
            throw new Exception("rename " + tmp_file + " -> " + file_path);
        }
    }

    // return null if read error
    public static String read_text_file(String file_path) {
        try {
            File f = new File(file_path);
            FileInputStream s = new FileInputStream(f);
            // read whole file
            byte[] data = new byte[(int)f.length()];
            s.read(data);

            return new String(data, "utf-8");
        } catch (Exception e) {
            System.err.println("ERROR: read text file " + file_path);
            e.printStackTrace();
            return null;
        }
    }

    // return null if load error
    public static Json load_json(String file_path) {
        String text = read_text_file(file_path);
        if (null == text) {
            return null;
        } else {
            try {
                return Json.read(text);
            } catch (Exception e) {
                System.err.println("ERROR: load json file " + file_path);
                e.printStackTrace();
                return null;
            }
        }
    }

    // TODO
}
