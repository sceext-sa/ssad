package org.sceext.ssad.ssad_native;

import java.util.LinkedList;

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
    private final LinkedList<Json> _event_cache;
    private final SsadNative _ssad_native;

    private Promise _event_promise = null;

    public SsadNativeCore(SsadNative s) {
        _ssad_native = s;

        _event_cache = new LinkedList<>();
    }

    public String version_info() {
        Json o = Json.object()
            .set("ssad_native", Config.VERSION)
            .set("ssad_server", DServerConfig.VERSION)
            .set("http_server", Server.VERSION);
        return o.toString();
    }

    // put / pull events
    public synchronized void put_event(Json data) {
        if (_event_promise != null) {
            Json events = Json.array()
                .add(data);
            _event_promise.resolve(events.toString());
            _event_promise = null;  // reset promise
        } else {
            _event_cache.add(data);  // put event in cache
        }
    }

    public synchronized void pull_events(Promise promise) {
        if (_event_cache.size() > 0) {
            Json events = Json.make(_event_cache.toArray(new Json[0]));
            // clear cache
            _event_cache.clear();
            promise.resolve(events.toString());
        } else {
            _event_promise = promise;
        }
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
}
