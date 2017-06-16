// test ssad_server

import org.sceext.ssad_server.DServer;

public class App {

    public void test() throws Exception {
        DServer s = new DServer();
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
