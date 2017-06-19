package org.sceext.ssad.ssad_native;

import org.sceext.ssad_server.DServer;

import org.sceext.ssad.ServerService;
import org.sceext.ssad.MainApplication;


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
        int port = _mi().server_port();
        String root_key = _mi().root_key();
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
        _service.server_started();
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

    // server running info to show
    public String get_info() {
        return "127.0.0.1:" + _port;
    }

    private MainApplication _mi() {
        return MainApplication.instance();
    }
}
