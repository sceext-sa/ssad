package org.sceext.ssad.ssad_native;

import java.util.Map;
import java.util.HashMap;
import java.util.LinkedList;

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


public class SsadNative extends ReactContextBaseJavaModule {
    public static final String MODULE_NAME = "ssad_native";

    private final LinkedList<Json> _event_cache;
    private Promise _event_promise = null;

    public SsadNative(ReactApplicationContext context) {
        super(context);

        _event_cache = new LinkedList<>();
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

    // exports methods
    @ReactMethod
    public void status(Promise promise) {
        // TODO
    }

    @ReactMethod
    public void start_service(String opt, Promise promise) {
        // TODO
    }

    @ReactMethod
    public void stop_service(String opt, Promise promise) {
        // TODO
    }

    private String _version_info() {
        Json o = Json.object()
            .set("ssad_native", Config.VERSION)
            .set("ssad_server", DServerConfig.VERSION)
            .set("http_server", Server.VERSION);
        return o.toString();
    }
}
