package org.sceext.ssad_server;

import mjson.Json;

import org.sceext.http_server.Server;
import org.sceext.http_server.IReqCallback;
import org.sceext.http_server.IOnReq;
import org.sceext.ssad_server.builtin.MakeSsadKey;


public class DServer {
    private final DServerConfig _config;

    private Server _s;
    private final DCallback _cb;

    public DServer(DCallback cb) {
        _config = new DServerConfig();
        _cb = cb;
    }

    // get DServerConfig
    public DServerConfig config() {
        return _config;
    }

    public void run() throws Exception {
        // create server
        _s = new Server(new Callback(this, _cb), _config.port());
        // init
        init();
        // run server
        _s.run();
    }

    public void close() throws Exception {
        _s.close();
    }

    // ssad_server init process
    private void init() throws Exception {
        // TODO clean tmp dir ?

        // DEBUG config
        System.err.println("DEBUG: DServer config: ");
        System.err.println("DEBUG:    CONFIG_ROOT = " + _config.config_root());
        System.err.println("DEBUG:    DATA_ROOT = " + _config.data_root());
        System.err.println("DEBUG:    SDCARD_ROOT = " + _config.sdcard_root());
        System.err.println("DEBUG:    ROOT_APP = " + _config.root_app());

        // CONFIG_ROOT = /sdcard/.config/
        final String pub_root = "ssad_server/pub_root.json";
        final String sub_root = "ssad_server/sub_root.json";
        final String root_302 = "ssad_server/root_302";
        final String root_key = "ssad_server/root_key";

        String cr = _config.config_root();
        String pr = Util.merge_path(cr, pub_root);
        String sr = Util.merge_path(cr, sub_root);
        String r3 = Util.merge_path(cr, root_302);
        String rk = Util.merge_path(cr, root_key);
        // try load root_key
        String t = Util.read_text_file(rk);
        if (null == t) {
            // ignore error
        } else {
            _config.root_key(t.trim());  // trim root_key
            System.err.println("DEBUG: load " + rk);
        }
        // make root_key
        if (_config.root_key() == null) {
            _config.root_key(MakeSsadKey.make());
            System.err.println("DEBUG:    ROOT_KEY = " + _config.root_key());
        }

        // make default config
        System.err.println("DEBUG: load default config ");
        _config.config(_config.default_config());
        // load config files
        Json config = _config.config();  // read out
        Json j = null;

        j = Util.load_json(pr);
        if (null == j) {
            System.err.println("ERROR: load " + pr);
        } else {
            config.set("pub_root", j);
            System.err.println("DEBUG: load " + pr);
        }
        j = Util.load_json(sr);
        if (null == j) {
            System.err.println("ERROR: load " + sr);
        } else {
            config.set("sub_root", j);
            System.err.println("DEBUG: load " + sr);
        }
        t = Util.read_text_file(r3);
        if (null == t) {
            System.err.println("ERROR: load " + r3);
        } else {
            config.set("root_302", t.trim());
            System.err.println("DEBUG: load " + r3);
        }

        _config.config(config);  // set back
    }

    public static interface DCallback {
        public void on_start(String ip, int port);
        public void on_close();
    }

    private static class Callback implements IReqCallback {
        private final DServer _server;
        private final DCallback _cb;

        public Callback(DServer server, DCallback cb) {
            _server = server;
            _cb = cb;
        }

        @Override
        public IOnReq create_on_req() {
            return new OnReq(_server);
        }

        @Override
        public void on_listen(String ip, int port) {
            _cb.on_start(ip, port);
        }

        @Override
        public void on_close() {
            _cb.on_close();
        }
    }
}
