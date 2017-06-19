package org.sceext.ssad.ssad_native;

import android.widget.Toast;

import org.sceext.ssad_server.builtin.MakeSsadKey;


public class Util {
    // TODO

    public static String make_root_key() {
        return MakeSsadKey.make();
    }
}
