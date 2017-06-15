package org.sceext.ssad_server.builtin;

import java.io.FileInputStream;
import java.security.MessageDigest;


public class MakeSsadKey {
    public static String URANDOM = "/dev/urandom";
    private static final int RAW_SIZE = 64;  // 512bit
    private static final int OUT_SIZE = 32;  // 256bit

    // return null if error
    public static String make() {
        try {
            return _make();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private static byte[] _read_raw() throws Exception {
        FileInputStream s = new FileInputStream(URANDOM);
        byte[] data = new byte[RAW_SIZE];
        s.read(data);
        return data;
    }

    private static String _hex(byte[] data) {
        final String t = "0123456789abcdef";

        StringBuilder o = new StringBuilder(data.length * 2);
        for (int i = 0; i < data.length; i += 1) {
            byte b = data[i];

            o.append(t.charAt((b >> 4) & 0x0f));
            o.append(t.charAt(b & 0x0f));
        }
        return o.toString();
    }

    private static String _make() throws Exception {
        byte[] raw = _read_raw();
        // sha256
        byte[] out = MessageDigest.getInstance("SHA-256").digest(raw);
        return _hex(out);
    }
}
