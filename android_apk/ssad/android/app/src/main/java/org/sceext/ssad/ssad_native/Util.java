package org.sceext.ssad.ssad_native;

import android.widget.Toast;

// import org.sceext.ssad_server.Util;
import org.sceext.ssad_server.builtin.MakeSsadKey;


public class Util {
    // TODO

    public static String make_root_key() {
        return MakeSsadKey.make();
    }

    public static void write_text_file(String filename, String text) throws Exception {
        org.sceext.ssad_server.Util.write_replace(filename, text);
    }

    public static String read_text_file(String filename) throws Exception {
        return org.sceext.ssad_server.Util.read_text_file(filename);
    }
}
