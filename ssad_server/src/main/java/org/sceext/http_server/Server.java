// TODO
package org.sceext.http_server;

import io.netty.bootstrap.ServerBootstrap;
import io.netty.channel.Channel;
import io.netty.channel.EventLoopGroup;
import io.netty.channel.oio.OioEventLoopGroup;
import io.netty.channel.socket.oio.OioServerSocketChannel;
import io.netty.handler.logging.LogLevel;
import io.netty.handler.logging.LoggingHandler;


public class Server {
    public static final String VERSION = "netty http_server version 0.2.0-1 test20170617 0135";

    private int _port = 8080;
    private String _ip = "127.0.0.1";

    private final IReqCallback _callback;

    public Server(IReqCallback callback) {
        _callback = callback;
    }

    public Server(IReqCallback callback, int port) {
        this(callback);

        _port = port;
    }

    public void run() throws Exception {
        EventLoopGroup master_group = new OioEventLoopGroup(1);
        EventLoopGroup slave_group = new OioEventLoopGroup();
        try {
            ServerBootstrap b = new ServerBootstrap();
            b.group(master_group, slave_group)
             .channel(OioServerSocketChannel.class)
             .handler(new LoggingHandler(LogLevel.DEBUG))
             .childHandler(new NettyInit(_callback));
            Channel ch = b.bind(_ip, _port).sync().channel();

            // server on_listen callback
            _callback.on_listen(_ip, _port);

            ch.closeFuture().sync();
        } finally {
            master_group.shutdownGracefully();
            slave_group.shutdownGracefully();

            _callback.on_close();
        }
    }

    public void close() throws Exception {
        // TODO
    }
}