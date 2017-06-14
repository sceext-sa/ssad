package org.sceext.ssad_server;

import mjson.Json;

import org.sceext.http_server.OneReq;


public class OnReq extends OnReqBase {
    public static final String URL_ROOT = "/";
    // ssad_server URL root: `/ssad201706/`
    public static final String PUB_ROOT = "/ssad201706/pub/";
    public static final String KEY_ROOT = "/ssad201706/key/";

    public OnReq(DServer server) {
        super(server);
    }

    @Override
    protected Json _on_req(Json info, String path) throws Exception {
        // check path (root router)
        if (path.startsWith(KEY_ROOT)) {
            // update rest path
            _set_rest_path(KEY_ROOT);
            // route to sub_root
            _sub = new SubRoot(_server);
            return _sub.on_req(_req);
        } else if (path.startsWith(PUB_ROOT)) {
            // update rest path
            _set_rest_path(PUB_ROOT);
            // route to pub_root
            _sub = new PubRoot(_server);
            return _sub.on_req(_req);
        } else if (path.equals(URL_ROOT)) {
            String location = _config().at("root_302").asString();
            // send root redirect
            return OneReq.res_redirect(location);
        } else {
            return OneReq.res_code(404);  // HTTP 404 Not Found
        }
    }
}
