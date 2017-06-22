package org.sceext.ssad.ssad_native;

import mjson.Json;

import org.sceext.ssad.MainApplication;
import org.sceext.ssad.ServerService;
import org.sceext.ssad.ClipService;


public class Config {
    public static final String VERSION = "ssad_native version 0.2.0-2 test20170622 2300";

    public static final String SERVICE_STARTED = "service_started";
    public static final String SERVICE_STOPPED = "service_stopped";
    public static final String CLIP_CHANGED = "clip_changed";
    public static final String SERVER_SERVICE = "server_service";
    public static final String CLIP_SERVICE = "clip_service";
    public static final String TYPE = "type";
    public static final String DATA = "data";
    public static final String NAME = "name";
    public static final String SERVER_EXIT = "server_exit";

    public static final int SERVER_SERVICE_ID = 1;
    public static final int CLIP_SERVICE_ID = 2;

    public static String CLIP_LOG_DIR = "/sdcard/ssad/ssad_clip/log/";
    public static String CLIP_LIST_FILE = "/sdcard/ssad/ssad_clip/clip_list.json";

    private final ClipLog _clip_log;

    public Config() {
        _clip_log = new ClipLog();
    }

    // get single instance
    public static Config i() {
        return MainApplication.config();
    }

    // runtime configs
    private String _webview_url;

    private ServerService _server_service;
    private ClipService _clip_service;

    // config to start ssad_server
    //  {
    //      port: ''
    //      root_key: ''
    //  }
    private Json _server_start_config;
    private SsadNativeCore _ssad_native_core;


    // get / set
    public String webview_url() {
        return _webview_url;
    }
    public Config webview_url(String url) {
        _webview_url = url;
        return this;
    }

    public ServerService server_service() {
        return _server_service;
    }
    public Config server_service(ServerService s) {
        _server_service = s;
        return this;
    }
    public ClipService clip_service() {
        return _clip_service;
    }
    public Config clip_service(ClipService s) {
        _clip_service = s;
        return this;
    }

    public Json server_start_config() {
        return _server_start_config;
    }
    public Config server_start_config(Json config) {
        _server_start_config = config;
        return this;
    }
    public SsadNativeCore ssad_native_core() {
        return _ssad_native_core;
    }
    public Config ssad_native_core(SsadNativeCore s) {
        _ssad_native_core = s;
        return this;
    }
    public ClipLog clip_log() {
        return _clip_log;
    }

    public static void put_event(Json data) {
        i().ssad_native_core().put_event(data);
    }

    public static void put_event_clip(Json data) {
        i().ssad_native_core().put_event_clip(data);
    }
}
