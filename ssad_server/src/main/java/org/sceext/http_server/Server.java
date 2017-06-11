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
    public static final String VERSION = "netty http_server version 0.1.0 test20170611 2336";

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
            System.out.println("DEBUG: listen at " + _ip + ":" + _port);

            ch.closeFuture().sync();
        } finally {
            master_group.shutdownGracefully();
            slave_group.shutdownGracefully();
        }
    }
}
