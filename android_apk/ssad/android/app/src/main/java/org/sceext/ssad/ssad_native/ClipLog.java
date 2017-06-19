package org.sceext.ssad.ssad_native;

import java.io.File;
import java.io.FileOutputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;

import mjson.Json;


public class ClipLog {

    public static void log(String text, boolean is_text) {
        String to_log = _print_log(text, is_text);
        try {
            _log(to_log);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static void _log(String to_log) throws Exception {
        File f = new File(Config.CLIP_LOG_DIR);
        if (! f.exists()) {
            // try create dir
            System.err.println("ClipLog: create dir " + f.getAbsolutePath());
            f.mkdirs();
        }
        File log = new File(f, _get_filename());
        // append mode
        FileOutputStream s = new FileOutputStream(log, true);
        s.write(to_log.getBytes("utf-8"));
        s.flush();
        s.close();
    }

    private static String _get_filename() {
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        return df.format(new Date()) + ".log";
    }

    public static final String TIME_ISO8601_FORMAT = "yyyy-MM-dd'T'HH:mm:ss:SSS'Z'";

    private static String _print_time() {
        TimeZone tz = TimeZone.getTimeZone("UTC");
        DateFormat df = new SimpleDateFormat(TIME_ISO8601_FORMAT);
        df.setTimeZone(tz);
        return df.format(new Date());
    }

    private static String _print_log(String text, boolean is_text) {
        String type = "text";
        if (! is_text) {
            type = "unknow";
        }
        Json o = Json.object()
            .set("time", _print_time())
            .set("type", type)
            .set("text", text);
        return o.toString() + "\n";
    }
}
