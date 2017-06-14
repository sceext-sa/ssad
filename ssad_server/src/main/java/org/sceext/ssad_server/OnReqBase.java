package org.sceext.ssad_server;

import mjson.Json;

import org.sceext.http_server.IOnReq;
import org.sceext.http_server.OneReq;


public abstract class OnReqBase implements IOnReq {
    protected final DServer _server;
    protected OneReq _req;

    // route POST (got_post_data) to this sub object
    protected IOnReq _sub;

    public OnReqBase(DServer server) {
        _server = server;
    }

    @Override
    public Json on_req(OneReq req) throws Exception {
        _req = req;

        return _on_req(_req.req_info(), _path());
    }

    // req_info.path
    protected String _path() {
        return _req.req_info().at(OneReq.PATH).asString();
    }

    // ssad_server runtime (json) config
    protected Json _config() {
        return _server.config().config();
    }

    protected void _set_rest_path(int len) {
        String rest = _path().substring(len);
        _req.req_info().set(OneReq.PATH, rest);
    }

    protected void _set_rest_path(String root_path) {
        _set_rest_path(root_path.length());
    }

    protected abstract Json _on_req(Json info, String path) throws Exception;

    @Override
    public Json got_post_data(byte[] data) throws Exception {
        if (_sub != null) {
            return _sub.got_post_data(data);
        } else {
            throw new Exception("_sub is null");
        }
    }
}
