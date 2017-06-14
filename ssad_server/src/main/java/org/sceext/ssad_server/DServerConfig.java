package org.sceext.ssad_server;

import mjson.Json;


public class DServerConfig {
    // ssad_server version
    public static final String VERSION = "ssad_server version 0.1.0-1 test20170614 2331";

    // ssad_server runtime (json) config
    private Json _config = null;

    // root_key (root ssad_key)
    private String _root_key = "";
    // ROOT_APP
    private String _root_app = "root_app";
    // SSAD_CONFIG_ROOT
    private String _config_root = "/sdcard/.config/";
    // SSAD_DATA_ROOT
    private String _data_root = "/sdcard/ssad/";
    // SDCARD_ROOT
    private String _sdcard_root = "/sdcard/";

    // port to listen (server)
    private int _port;

    // get / set

    // config json struct
    //
    // ```
    // {
    //     pub_root: {},
    //     sub_root: {},
    //     root_302: '',
    // }
    // ```

    public Json config() {
        return _config;
    }

    public void config(Json c) {
        _config = c;
    }

    // make a default ssad_server json config
    public Json default_config() {
        Json o = Json.object();
        // pub_root
        Json pr = Json.object()
            .set("app", Json.object()
                .set("root_app", Json.object()
                    .set("app_meta",
                        // /sdcard/ssad/
                        data_root() + "app/root_app/ssad_app.meta.json"
                    )
                )
            );
        o.set("pub_root", pr);
        // sub_root
        Json sr = Json.object()
            .set("app", Json.object()
                .set("root_app", Json.object()
                    .set("key", root_key())
                    .set("sub", Json.object()
                        .set("sdcard", Json.object()
                            .set("path", sdcard_root())
                            .set("allow", Json.object()
                                .set("list", true)
                                .set("ro", true)
                            )
                        )
                    )
                )
            );
        o.set("sub_root", sr);
        // root_302
        o.set("root_302", "/ssad201706/pub/root_app/");

        return o;
    }

    public String root_key() {
        return _root_key;
    }

    public void root_key(String k) {
        _root_key = k;
    }

    public String root_app() {
        return _root_app;
    }

    public void root_app(String r) {
        _root_app = r;
    }

    public String config_root() {
        return _config_root;
    }

    public void config_root(String c) {
        _config_root = c;
    }

    public String data_root() {
        return _data_root;
    }

    public void data_root(String d) {
        _data_root = d;
    }

    public String sdcard_root() {
        return _sdcard_root;
    }

    public void sdcard_root(String s) {
        _sdcard_root = s;
    }

    public int port() {
        return _port;
    }

    public void port(int p) {
        _port = p;
    }
}
