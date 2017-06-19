package org.sceext.ssad.ssad_native;

import org.sceext.ssad.ServerService;


public class ServerThread implements Runnable {
    private ServerService _service;
    // DEBUG
    private boolean _exit = false;

    public ServerThread(ServerService service) {
        _service = service;
    }

    @Override
    public void run() {
        // TODO FIXME fake server
        _service.show_notification();
        // TODO
        while (! _exit) {
            try {
                Thread.sleep(2000);
            } catch (Exception e) {
                break;
            }
        }
    }

    // close server
    public void close() {
        // TODO fake server
        _exit = true;
    }
}
