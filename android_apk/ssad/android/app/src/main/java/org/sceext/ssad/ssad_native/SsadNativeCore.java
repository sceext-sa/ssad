package org.sceext.ssad.ssad_native;

import android.content.Context;
import android.content.Intent;

import com.facebook.react.bridge.Promise;

import mjson.Json;

import org.sceext.json.JsonPretty;
import org.sceext.http_server.Server;
import org.sceext.ssad_server.DServerConfig;
import org.sceext.ssad.SsadNative;
import org.sceext.ssad.MainApplication;
import org.sceext.ssad.WebviewActivity;
import org.sceext.ssad.ClipActivity;
import org.sceext.ssad.ServerService;
import org.sceext.ssad.ClipService;


public class SsadNativeCore {
    private final SsadNative _ssad_native;

    private final EventCache _event_cache;
    private final EventCache _event_cache_clip;

    public SsadNativeCore(SsadNative s) {
        _ssad_native = s;

        _event_cache = new EventCache();
        _event_cache_clip = new EventCache();
    }

    public String version_info() {
        Json o = Json.object()
            .set("ssad_native", Config.VERSION)
            .set("ssad_server", DServerConfig.VERSION)
            .set("http_server", Server.VERSION);
        return o.toString();
    }

    // put / pull events
    public void put_event(Json data) {
        _event_cache.put_event(data);
    }

    public void pull_events(Promise promise) {
        _event_cache.pull_events(promise);
    }

    // clip events
    public void put_event_clip(Json data) {
        _event_cache_clip.put_event(data);
    }

    public void pull_events_clip(Promise promise) {
        _event_cache_clip.pull_events(promise);
    }


    public String status() {
        ServerService ss = Config.i().server_service();
        ClipService cs = Config.i().clip_service();
        Json o = Json.object()
            .set("service_running_server", (ss != null))
            .set("service_running_clip", (cs != null));
        // check server port
        if (ss != null) {
            o.set("server_port", ss.port());
        }
        return o.toString();
    }

    // get / set root_key
    public String root_key() throws Exception {
        ServerService s = Config.i().server_service();
        if (s != null) {
            return s.root_key();
        } else {
            throw new Exception("ServerService not running");
        }
    }

    public SsadNativeCore root_key(String key) throws Exception {
        ServerService s = Config.i().server_service();
        if (s != null) {
            s.root_key(key);
        } else {
            throw new Exception("ServerService not running");
        }
        return this;
    }

    public String make_root_key() {
        return Util.make_root_key();
    }

    public void start_webview(String opts) throws Exception {
        Json opt = Json.read(opts);
        String url = opt.at("url").asString();
        // save webview_url
        Config.i().webview_url(url);

        Context c = _ssad_native.context();
        // start WebviewActivity
        Intent intent = new Intent(c, WebviewActivity.class)
            .setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_NEW_DOCUMENT | Intent.FLAG_ACTIVITY_MULTIPLE_TASK);
        c.startActivity(intent);
    }

    public void start_server(String opts) throws Exception {
        Json opt = Json.read(opts);
        // save server_start_config
        Config.i().server_start_config(opt);

        Context c = _ssad_native.context();
        Intent intent = new Intent(c, ServerService.class);
        // start server service
        c.startService(intent);
    }

    public void start_clip(String opts) throws Exception {
        Context c = _ssad_native.context();
        c.startService(new Intent(c, ClipService.class));
    }

    public void stop_service(String opts) throws Exception {
        Json opt = Json.read(opts);
        String name = opt.at(Config.NAME).asString();
        Context c = _ssad_native.context();

        if (name.equals(Config.SERVER_SERVICE)) {
            c.stopService(new Intent(c, ServerService.class));
        } else if (name.equals(Config.CLIP_SERVICE)) {
            c.stopService(new Intent(c, ClipService.class));
        } else {
            throw new Exception("unknow service name " + name);
        }
    }

    // SSAD clip
    public SsadNativeCore set_primary_clip(String text) throws Exception {
        ClipService s = Config.i().clip_service();
        if (s != null) {
            s.set_clip(text);
        } else {
            throw new Exception("ClipService not running");
        }
        return this;
    }

    public String get_clip() {
        Json data = Config.i().clip_log().get_clip();
        return data.toString();
    }

    public void set_clip(String raw) throws Exception {
        Json data = Json.read(raw);
        Config.i().clip_log().set_clip(data);
    }

    public void load_clip_file() throws Exception {
        Config.i().clip_log().load_clip_file();
    }
}
