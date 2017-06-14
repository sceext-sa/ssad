package org.sceext.http_server;

public interface IReqCallback {
    public IOnReq create_on_req();

    // at server started
    public void on_listen(String ip, int port);
    // server stoped
    public void on_close();
}
