// test ssad_server

import org.sceext.ssad_server.DServer;


public class App {

    /* TODO
    // check parent dir
    File parent = to_upload.getParentFile();
    if (! parent.isDirectory()) {
        // DEBUG
        System.out.println("WARNING: parent dir not exist ! " + parent.getCanonicalFile().getAbsolutePath());
        // try to create dir
        if (! parent.mkdirs()) {
            System.out.println("ERROR: can not create dir " + parent.getCanonicalFile().getAbsolutePath());
            o.set("type", "code");
            o.set("code", 404);  // HTTP 404 Not Found
            return;
        }
    }
    */

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
