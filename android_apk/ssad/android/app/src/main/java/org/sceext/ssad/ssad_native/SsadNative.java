package org.sceext.ssad.ssad_native;

import java.util.Map;
import java.util.HashMap;
import java.util.LinkedList;

import android.content.Context;
import android.content.Intent;

import com.facebook.react.bridge.NativeModule;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.Promise;

import mjson.Json;

import org.sceext.json.JsonPretty;
import org.sceext.http_server.Server;
import org.sceext.ssad_server.DServerConfig;
import org.sceext.ssad.MainApplication;
import org.sceext.ssad.WebviewActivity;
import org.sceext.ssad.ServerService;
import org.sceext.ssad.ClipService;


public class SsadNative extends ReactContextBaseJavaModule {
    public static final String MODULE_NAME = "ssad_native";

    private final LinkedList<Json> _event_cache;
    private Promise _event_promise = null;

    public SsadNative(ReactApplicationContext context) {
        super(context);

        _event_cache = new LinkedList<>();
        // save this to MainApplication
        _mi().set_ssad_native(this);
    }

    @Override
    public String getName() {
        return MODULE_NAME;
    }

    @Override
    public Map<String, Object> getConstants() {
        final Map<String, Object> c = new HashMap<>();
        // static version info
        c.put("VERSION_INFO", _version_info());
        return c;
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

    // export methods
    @ReactMethod
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

    @ReactMethod
    public void start_webview(String opt, Promise promise) {
        try {
            _start_webview(opt);
            promise.resolve(null);
        } catch (Exception e) {
            promise.reject("error", e);
        }
    }

    @ReactMethod
    public void get_webview_url(Promise promise) {
        String url = _mi().webview_url();
        promise.resolve(url);
    }

    @ReactMethod
    public void status(Promise promise) {
        Json o = Json.object()
            .set("service_running_server", _mi().service_running_server())
            .set("service_running_clip", _mi().service_running_clip())
            .set("server_port", _mi().server_port());
        promise.resolve(o.toString());
    }

    @ReactMethod
    public void set_root_key(String key, Promise promise) {
        _mi().root_key(key);
        promise.resolve(null);
    }

    @ReactMethod
    public void get_root_key(Promise promise) {
        promise.resolve(_mi().root_key());
    }

    @ReactMethod
    public void make_root_key(Promise promise) {
        promise.resolve(Util.make_root_key());
    }

    @ReactMethod
    public void start_service(String opt, Promise promise) {
        try {
            _start_stop_service(opt, true);
            promise.resolve(null);
        } catch (Exception e) {
            promise.reject("error", e);
        }
    }

    @ReactMethod
    public void stop_service(String opt, Promise promise) {
        try {
            _start_stop_service(opt, false);
            promise.resolve(null);
        } catch (Exception e) {
            promise.reject("error", e);
        }
    }

    private String _version_info() {
        Json o = Json.object()
            .set("ssad_native", Config.VERSION)
            .set("ssad_server", DServerConfig.VERSION)
            .set("http_server", Server.VERSION);
        return o.toString();
    }

    private MainApplication _mi() {
        return MainApplication.instance();
    }

    private void _start_webview(String opts) throws Exception {
        Json opt = Json.read(opts);
        String url = opt.at("url").asString();
        // save webview_url
        _mi().webview_url(url);

        Context c = getReactApplicationContext();

        // start WebviewActivity
        Intent intent = new Intent(c, WebviewActivity.class)
            .setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_NEW_DOCUMENT | Intent.FLAG_ACTIVITY_MULTIPLE_TASK);
        c.startActivity(intent);
    }

    private void _start_stop_service(String opts, boolean start_true_or_stop) throws Exception {
        Json opt = Json.read(opts);
        String name = opt.at("name").asString();

        Context c = getReactApplicationContext();
        Intent intent = null;
        // check service name
        if (name.equals("server_service")) {
            intent = new Intent(c, ServerService.class);
            // check set port
            if (opt.has("port")) {
                int port = opt.at("port").asInteger();
                _mi().server_port(port);
            }
        } else if (name.equals("clip_service")) {
            intent = new Intent(c, ClipService.class);
        } else {
            throw new Exception("unknow service_name " + name);
        }
        if (start_true_or_stop) {
            // start service
            c.startService(intent);
        } else {
            // stop service
            c.stopService(intent);
        }
    }
}
