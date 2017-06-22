package org.sceext.ssad;

import java.util.Map;
import java.util.HashMap;

import android.content.Context;

import com.facebook.react.bridge.NativeModule;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Promise;

import org.sceext.ssad.ssad_native.Config;
import org.sceext.ssad.ssad_native.SsadNativeCore;


public class SsadNative extends ReactContextBaseJavaModule {
    public static final String MODULE_NAME = "ssad_native";

    private final SsadNativeCore _c;

    public SsadNative(ReactApplicationContext context) {
        super(context);

        _c = new SsadNativeCore(this);
        Config.i().ssad_native_core(_c);
    }

    @Override
    public String getName() {
        return MODULE_NAME;
    }

    @Override
    public Map<String, Object> getConstants() {
        final Map<String, Object> c = new HashMap<>();
        // static version info
        c.put("VERSION_INFO", _c.version_info());
        // const strings
        c.put("EVENT_SERVICE_STARTED", Config.SERVICE_STARTED);
        c.put("EVENT_SERVICE_STOPPED", Config.SERVICE_STOPPED);
        c.put("EVENT_SERVER_EXIT", Config.SERVER_EXIT);
        c.put("EVENT_CLIP_CHANGED", Config.CLIP_CHANGED);
        c.put("SERVER_SERVICE", Config.SERVER_SERVICE);
        c.put("CLIP_SERVICE", Config.CLIP_SERVICE);
        return c;
    }

    // export methods
    @ReactMethod
    public synchronized void pull_events(Promise promise) {
        _c.pull_events(promise);
    }

    @ReactMethod
    public void get_webview_url(Promise promise) {
        promise.resolve(Config.i().webview_url());
    }

    @ReactMethod
    public void status(Promise promise) {
        promise.resolve(_c.status());
    }

    @ReactMethod
    public void set_root_key(String key, Promise promise) {
        try {
            _c.root_key(key);
            promise.resolve(null);
        } catch (Exception e) {
            promise.reject("set_root_key error", e);
        }
    }

    @ReactMethod
    public void get_root_key(Promise promise) {
        try {
            promise.resolve(_c.root_key());
        } catch (Exception e) {
            promise.reject("get_root_key error", e);
        }
    }

    @ReactMethod
    public void make_root_key(Promise promise) {
        promise.resolve(_c.make_root_key());
    }

    @ReactMethod
    public void start_webview(String opt, Promise promise) {
        try {
            _c.start_webview(opt);
            promise.resolve(null);
        } catch (Exception e) {
            promise.reject("start_webview error", e);
        }
    }

    @ReactMethod
    public void start_server(String opt, Promise promise) {
        try {
            _c.start_server(opt);
            promise.resolve(null);
        } catch (Exception e) {
            promise.reject("start_server error", e);
        }
    }

    @ReactMethod
    public void start_clip(String opt, Promise promise) {
        try {
            _c.start_clip(opt);
            promise.resolve(null);
        } catch (Exception e) {
            promise.reject("start_clip error", e);
        }
    }

    @ReactMethod
    public void stop_service(String opt, Promise promise) {
        try {
            _c.stop_service(opt);
            promise.resolve(null);
        } catch (Exception e) {
            promise.reject("stop_service error", e);
        }
    }

    // for SSAD clip
    @ReactMethod
    public void set_primary_clip(String text, Promise promise) {
        try {
            _c.set_primary_clip(text);
            promise.resolve(null);
        } catch (Exception e) {
            promise.reject("set_primary_clip error", e);
        }
    }

    @ReactMethod
    public void get_clip(Promise promise) {
        promise.resolve(_c.get_clip());
    }

    @ReactMethod
    public void set_clip(String data, Promise promise) {
        try {
            _c.set_clip(data);
            promise.resolve(null);
        } catch (Exception e) {
            promise.reject("set_clip error", e);
        }
    }

    @ReactMethod
    public void pull_events_clip(Promise promise) {
        _c.pull_events_clip(promise);
    }

    @ReactMethod
    public void load_clip_file(Promise promise) {
        try {
            _c.load_clip_file();
            promise.resolve(null);
        } catch (Exception e) {
            promise.reject("load_clip_file error", e);
        }
    }


    // get Application Context
    public Context context() {
        return getReactApplicationContext();
    }
}
