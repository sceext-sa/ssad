package org.sceext.ssad_server;

import mjson.Json;

import org.sceext.http_server.Server;
import org.sceext.http_server.IReqCallback;
import org.sceext.http_server.IOnReq;


public class DServer {
    private final DServerConfig _config;

    public DServer() {
        _config = new DServerConfig();

        // TODO
    }

    // get DServerConfig
    public DServerConfig config() {
        return _config;
    }

    public void start() throws Exception {
        // TODO
    }

    public void run() throws Exception {
        // TODO ?
    }

    public void close() throws Exception {
        // TODO
    }

    // ssad_server init process
    private void init() throws Exception {
        // TODO TODO clean tmp dir ?
        // TODO make default config ?
        // TODO load config files

        // TODO start http_server ?
    }

    static class Callback implements IReqCallback {
        private final DServer _server;

        public Callback(DServer server) {
            _server = server;
        }

        @Override
        public IOnReq create_on_req() {
            return new OnReq(_server);
        }

        @Override
        public void on_listen(String ip, int port) {
            // TODO
            System.err.println("DEBUG: server listen at " + ip + ":" + port);
        }

        @Override
        public void on_close() {
            // TODO
            System.err.println("DEBUG: server closed");
        }
    }
}
