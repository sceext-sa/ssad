package org.sceext.http_server;

import mjson.Json;

public interface IOnReq {
    // `on_req()` will run on handler thread of netty
    public Json on_req(OneReq req) throws Exception;
    // `got_post_data()` will run on a worker thread
    public Json got_post_data(byte[] data) throws Exception;
}
