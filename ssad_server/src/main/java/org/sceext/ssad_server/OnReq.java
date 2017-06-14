package org.sceext.ssad_server;

import mjson.Json;

import org.sceext.http_server.IOnReq;
import org.sceext.http_server.OneReq;


public class OnReq implements IOnReq {
    private final DServer _server;
    private OneReq _req;

    public OnReq(DServer server) {
        _server = server;
        // TODO
    }

    @Override
    public Json on_req(OneReq req) throws Exception {
        _req = req;

        // TODO
        return null;
    }

    @Override
    public Json got_post_data(byte[] data) throws Exception {
        // TODO

        return null;
    }
}
