package org.sceext.http_server;

import io.netty.channel.ChannelInitializer;
import io.netty.channel.ChannelPipeline;
import io.netty.channel.socket.SocketChannel;
import io.netty.handler.codec.http.HttpRequestDecoder;
import io.netty.handler.codec.http.HttpResponseEncoder;
import io.netty.handler.stream.ChunkedWriteHandler;


public class NettyInit extends ChannelInitializer<SocketChannel> {
    private final IReqCallback _callback;

    public NettyInit(IReqCallback callback) {
        super();

        _callback = callback;
    }

    @Override
    public void initChannel(SocketChannel ch) {
        ChannelPipeline p = ch.pipeline();
        p.addLast(new HttpRequestDecoder());
        p.addLast(new HttpResponseEncoder());
        p.addLast(new ChunkedWriteHandler());
        p.addLast(new NettyHandler(_callback));
    }
}
