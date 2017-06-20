package org.sceext.ssad.ssad_native;

import mjson.Json;

import org.sceext.ssad_server.DServer;
import org.sceext.ssad.ServerService;


public class ServerThread implements Runnable {
    private ServerService _service;
    private int _port = 4444;

    private DServer _s;


    public ServerThread(ServerService service) {
        _service = service;
    }

    @Override
    public void run() {
        try {
            _run();
        } catch (Exception e) {
            e.printStackTrace();
        }
        _service.thread_exit();
    }

    class Callback implements DServer.DCallback {
        private final ServerThread _s;

        public Callback(ServerThread s) {
            _s = s;
        }

        @Override
        public void on_start(String ip, int port) {
            _s.on_start(ip, port);
        }

        @Override
        public void on_close() {
            _s.on_close();
        }
    }

    private void _run() throws Exception {
        // get port and root_key
        Json c = Config.i().server_start_config();
        int port = c.at("port").asInteger();
        String root_key = c.at("root_key").asString();

        // create server, and set config
        _s = new DServer(new Callback(this));
        _s.config()
          .port(port)
          .root_key(root_key);
        // run server
        _s.run();
    }

    public void on_start(String ip, int port) {
        _port = port;
        _service.server_started(ip, port);
    }

    public void on_close() {
        _service.server_closed();
    }

    // close server
    public void close() {
        try {
            _s.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // get / set root_key
    public String root_key() {
        return _s.config().root_key();
    }
    public void root_key(String key) {
        _s.config().root_key(key);
    }
}
