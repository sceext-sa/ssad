package org.sceext.http_server;

import java.util.List;
import java.util.Map;

import io.netty.buffer.ByteBuf;
import io.netty.buffer.Unpooled;
import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.SimpleChannelInboundHandler;
import io.netty.handler.codec.DecoderResult;
import io.netty.handler.codec.http.DefaultFullHttpResponse;
import io.netty.handler.codec.http.FullHttpResponse;
import io.netty.handler.codec.http.HttpContent;
import io.netty.handler.codec.http.HttpHeaders;
import io.netty.handler.codec.http.HttpObject;
import io.netty.handler.codec.http.HttpRequest;
import io.netty.handler.codec.http.HttpResponseStatus;
import io.netty.handler.codec.http.HttpUtil;
import io.netty.handler.codec.http.HttpVersion;
import io.netty.handler.codec.http.LastHttpContent;
import io.netty.handler.codec.http.QueryStringDecoder;

import mjson.Json;


public class NettyHandler extends SimpleChannelInboundHandler<Object> {

    // private attr
    private HttpRequest _req;
    private OneReq _one;
    private final IReqCallback _callback;
    private Json _info;  // req info

    // private attr used by OneReq
    private ChannelHandlerContext _ctx;
    private boolean _is_keep_alive;
    private boolean _is_100_expected = false;

    public NettyHandler(IReqCallback callback) {
        super();

        _callback = callback;
    }

    // public methods used by OneReq

    public ChannelHandlerContext ctx() {
        return _ctx;
    }

    public boolean is_keep_alive() {
        return _is_keep_alive;
    }

    // start get post data
    public void get_post_data() {
        if (_is_100_expected) {
            _send_100_continue();
        }
        resume();
    }

    // pause read (recv) data from channel
    public void pause() {
        _ctx.channel().config().setAutoRead(false);
    }

    // resume read (recv) data from channel
    public void resume() {
        _ctx.channel().config().setAutoRead(true);
    }

    // public methods used by Netty

    @Override
    public void handlerAdded(ChannelHandlerContext ctx) throws Exception {
        super.handlerAdded(ctx);
        _ctx = ctx;
        // create one_req
        _one = new OneReq(this, _callback);
    }

    @Override
    public void channelReadComplete(ChannelHandlerContext ctx) {
        _one._channel_read_complete();
    }

    @Override
    protected void channelRead0(ChannelHandlerContext ctx, Object msg) {
        if (msg instanceof HttpRequest) {
            _on_http_req(ctx, (HttpRequest) msg);
        }
        if (msg instanceof HttpContent) {
            _on_http_content(ctx, (HttpContent) msg);
        }
    }

    @Override
    public void exceptionCaught(ChannelHandlerContext ctx, Throwable cause) {
        cause.printStackTrace();
        ctx.close();
    }

    // private methods

    private void _on_http_req(ChannelHandlerContext ctx, HttpRequest req) {
        _req = req;  // save req
        pause();  // pause recv first

        // check bad request
        DecoderResult result = req.decoderResult();
        if (! result.isSuccess()) {
            // send HTTP 400 Bad Request
            _one._send_code(400);
            return;
        }
        // check keep-alive, 100 continue expected
        if (HttpUtil.is100ContinueExpected(req)) {
            _is_100_expected = true;
        }
        _is_keep_alive = HttpUtil.isKeepAlive(req);

        // get req info
        _info = Json.object();
        _info.set(OneReq.HTTP_VERSION, req.protocolVersion().toString());
        _info.set(OneReq.FULL_URL, req.uri());
        _info.set(OneReq.METHOD, req.method().name());
        // http headers
        Json header = Json.object();
        _info.set(OneReq.HEADER, header);
        HttpHeaders headers = req.headers();
        if (! headers.isEmpty()) {
            for (Map.Entry<String, String> h: headers) {
                // convert header names to lower case
                header.set(h.getKey().toLowerCase(), h.getValue());
            }
        }
        // decode query string
        Json query = Json.object();
        _info.set(OneReq.QUERY, query);
        QueryStringDecoder qd = new QueryStringDecoder(req.uri());
        Map<String, List<String>> ps = qd.parameters();
        if (! ps.isEmpty()) {
            for (Map.Entry<String, List<String>> p: ps.entrySet()) {
                String key = p.getKey();
                List<String> v = p.getValue();
                if (v.size() > 0) {
                    String value = v.get(0);
                    query.set(key, value);
                }
            }
        }
        // set request info
        _one.req_info(_info);
        _one._call_on_req();
    }

    private void _on_http_content(ChannelHandlerContext ctx, HttpContent content) {
        // check POST content
        ByteBuf buf = content.content();
        if (buf.isReadable()) {
            byte[] data = new byte[buf.readableBytes()];
            buf.readBytes(data);
            _one._on_post_data(data);
        }

        if (content instanceof LastHttpContent) {
            LastHttpContent last = (LastHttpContent) content;
            // TODO check more headers ?
            _one._on_end();
        }
    }

    private void _send_100_continue() {
        FullHttpResponse res = new DefaultFullHttpResponse(HttpVersion.HTTP_1_1, HttpResponseStatus.CONTINUE);
        _ctx.writeAndFlush(res);
    }
}
