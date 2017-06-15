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

    public static void delete_file(String file_path) throws Exception {
        File f = new File(file_path);
        if (! f.delete()) {
            throw new Exception("delete " + file_path);
        }
    }

    public static String merge_path(String a, String b) {
        File f = new File(a);
        f = new File(f, b);
        return f.getPath();
    }

    public static String merge_path(String a, String b, String c) {
        File f = new File(a);
        f = new File(f, b);
        f = new File(f, c);
        return f.getPath();
    }

    public static String norm_path(String path) throws Exception {
        File f = new File(path);
        return f.getCanonicalFile().getAbsolutePath();
    }

    public static boolean is_path_security(String root, String path) {
        try {
            root = norm_path(root);
            if (! root.endsWith("/")) {
                root += "/";
            }
            path = norm_path(path);
            if (! path.endsWith("/")) {
                path += "/";
            }
            if (path.startsWith(root)) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static Json list_dir(String file_path) throws Exception {
        File f = new File(file_path);
        File[] s = f.listFiles();
        Json dir = Json.object();
        for (File i: s) {
            Json one = Json.object();
            if (i.isFile()) {
                one.set("type", "file");
                one.set("size", i.length());
            } else if (i.isDirectory()) {
                one.set("type", "dir");
            } else {
                one.set("type", "unknow");
            }
            dir.set(i.getName(), one);
        }
        Json o = Json.object()
            .set("dir", dir);
        return o;
    }

    // TODO
}
