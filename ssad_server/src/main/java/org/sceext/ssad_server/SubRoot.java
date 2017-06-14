package org.sceext.ssad_server;

import mjson.Json;

import org.sceext.http_server.OneReq;


public class SubRoot extends OnReqBase {

    public SubRoot(DServer server) {
        super(server);
    }

    @Override
    protected Json _on_req(Json info, String path) throws Exception {
        // TODO

        return OneReq.res_code(404);  // HTTP 404 Not Found
    }
}
