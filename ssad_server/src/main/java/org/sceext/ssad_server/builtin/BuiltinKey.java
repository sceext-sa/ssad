package org.sceext.ssad_server.builtin;

import mjson.Json;

import org.sceext.http_server.OneReq;
import org.sceext.ssad_server.DServer;
import org.sceext.ssad_server.OnReqBase;


public class BuiltinKey extends OnReqBase {

    private String _path;

    public BuiltinKey(DServer server) {
        super(server);
    }

    @Override
    protected Json _on_req(Json info, String path) throws Exception {
        _path = path;

        // TODO
        return OneReq.res_code(501);
    }

    @Override
    public Json got_post_data(byte[] data) throws Exception {
        // TODO

        throw new Exception("NOT IMPLEMENTED");
    }
}
