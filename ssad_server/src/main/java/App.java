// test ssad_server

import org.sceext.ssad_server.DServer;

public class App {

    class Callback implements DServer.DCallback {
        @Override
        public void on_start(String ip, int port) {
            System.err.println("Server listen at " + ip + ":" + port);
        }

        @Override
        public void on_close() {
            System.err.println("Server closed");
        }
    }

    public void test() throws Exception {
        DServer s = new DServer(new Callback());
        // set configs
        s.config()
         .port(8082)
         .config_root("tmp/sdcard/config/")
         .data_root("tmp/sdcard/ssad/")
         .sdcard_root("tmp/sdcard/");
        // start / run server
        s.run();
    }

    public static void main(String[] args) throws Exception {
        // TODO process args ?
        new App().test();
    }
}
