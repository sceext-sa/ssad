package org.sceext.ssad.ssad_native;

import java.io.File;
import java.io.FileOutputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;

import mjson.Json;

import org.sceext.json.JsonPretty;


public class ClipLog {
    private Json _clip;  // internal clip (list) data struct
    //  {
    //      list: [
    //          {
    //              text: ''
    //              time: ''           // ISO8601  first time
    //              is_not_text: true  // [optional]  (default: false)
    //              hit: 1             // [optional] hit count  (default: 0)
    //              hit_time: ''       // [optional] ISO8601  last hit time
    //          }
    //      ]
    //      index: 0  // current clip text index
    //  }

    public ClipLog() {
        _clip = Json.object()
            .set("list", Json.array())
            .set("index", -1);
    }

    public synchronized void log(String text, boolean is_text) {
        // check text
        if (null == text) {
            text = "";
            is_text = false;
        }
        // write log file
        String to_log = _print_log(text, is_text);
        try {
            _log(to_log);
        } catch (Exception e) {
            e.printStackTrace();
        }
        // update internal clip list
        try {
            _update_clip(text, is_text);
            _save_clip_file();
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

    public static final String TIME_ISO8601_FORMAT = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";

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

    public synchronized Json get_clip() {
        return _clip;
    }

    public synchronized void set_clip(Json data) throws Exception {
        _check_clip_json_struct(data);
        // update it
        _clip = data;

        _save_clip_file();
    }

    private void _update_clip(String text, boolean is_text) throws Exception {
        Json[] list = _clip.at("list").asJsonList().toArray(new Json[0]);
        int index = -1;
        // scan list and find index
        for (int i = 0; i < list.length; i += 1) {
            Json one = list[i];
            if (one.at("text").asString().equals(text)) {
                index = i;
                // check is_text
                if (is_text && (one.has("is_not_text") && one.at("is_not_text").asBoolean())) {
                    one.set("is_not_text", false);
                }
                break;
            }
        }
        if (-1 == index) {
            Json one = Json.object()
                .set("text", text)
                .set("time", _print_time());
            if (! is_text) {
                one.set("is_not_text", true);
            }
            // update index
            _clip.set("index", list.length);
            // append new item
            _clip.at("list").add(one);
        } else {
            Json one = list[index];
            // update hit
            int hit = 0;
            if (one.has("hit")) {
                hit = one.at("hit").asInteger();
            }
            hit += 1;
            one.set("hit", hit);
            // hit time
            one.set("hit_time", _print_time());

            // update index
            _clip.set("index", index);
            // save new list
            _clip.set("list", Json.make(list));
        }
    }

    private void _save_clip_file() throws Exception {
        String text = JsonPretty.print(_clip) + "\n";
        Util.write_text_file(Config.CLIP_LIST_FILE, text);
    }

    public synchronized void load_clip_file() throws Exception {
        Json data = Json.read(Util.read_text_file(Config.CLIP_LIST_FILE));
        // check clip file format
        _check_clip_json_struct(data);
        // update it
        _clip = data;
    }

    private static void _check_clip_json_struct(Json data) throws Exception {
        if ((null == data) || (! data.isObject())) {
            throw new Exception("root is not Object");
        }
        if ((! data.has("list")) || (! data.at("list").isArray())) {
            throw new Exception("bad list");
        }
        if ((! data.has("index")) || (! data.at("index").isNumber())) {
            throw new Exception("bad index");
        }
        // check list
        Json[] list = data.at("list").asJsonList().toArray(new Json[0]);
        for (int i = 0; i < list.length; i += 1) {
            Json one = list[i];
            if ((null == one) || (! one.isObject())) {
                throw new Exception("list item " + i + " is not Object");
            }
            if ((! one.has("text")) || (! one.at("text").isString())) {
                throw new Exception("list item " + i + " bad text");
            }
            if ((! one.has("time")) || (! one.at("time").isString())) {
                throw new Exception("list item " + i + " bad time");
            }
            // optional attrs
            if (one.has("is_not_text") && (! one.at("is_not_text").isBoolean())) {
                throw new Exception("list item " + i + " bad is_not_text");
            }
            if (one.has("hit") && (! one.at("hit").isNumber())) {
                throw new Exception("list item " + i + " bad hit");
            }
            if (one.has("hit_time") && (! one.at("hit_time").isString())) {
                throw new Exception("list item " + i + " bad hit_time");
            }
        }
    }
}
