package org.sceext.ssad;

import android.app.Notification;
import android.app.PendingIntent;
import android.app.Service;
import android.content.Intent;
import android.os.IBinder;

import android.support.v4.app.NotificationCompat;

import mjson.Json;

import org.sceext.ssad.ssad_native.Config;
import org.sceext.ssad.ssad_native.ServerThread;


public class ServerService extends Service {
    private boolean _running = false;
    private int _port;

    private Thread _t;
    private ServerThread _s;

    @Override
    public void onCreate() {
        // create thread
        _s = new ServerThread(this);
        _t = new Thread(_s);

        // save this in config
        Config.i().server_service(this);
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        if (_running) {
            // WARNING
            System.err.println("ServerService: WARNING: start service while already running ");
            return START_NOT_STICKY;
        }
        // start thread
        _t.start();

        _running = true;  // set running flag
        return START_NOT_STICKY;
    }

    @Override
    public IBinder onBind(Intent intent) {
        return null;  // not allow bind
    }

    @Override
    public void onDestroy() {
        // close server
        _s.close();
        // waiting thread to exit
        try {
            _t.join();
        } catch (Exception e) {
            e.printStackTrace();  // ignore error
        }
        // remove this from config
        Config.i().server_service(null);

        remove_notification();
        // emit event
        Json event = Json.object()
            .set(Config.TYPE, Config.SERVICE_STOPPED)
            .set(Config.DATA, Json.object()
                .set(Config.NAME, Config.SERVER_SERVICE)
            );
        Config.put_event(event);
    }

    // show notification (run service in foreground)
    public void show_notification() {
        // create a notification
        Intent intent = new Intent(this, MainActivity.class);
        PendingIntent p = PendingIntent.getActivity(this, 0, intent, PendingIntent.FLAG_UPDATE_CURRENT);
        NotificationCompat.Builder b = new NotificationCompat.Builder(this)
            .setSmallIcon(R.mipmap.ic_launcher)
            .setContentTitle("ssad_server is running")
            .setContentText("127.0.0.1:" + _port)
            .setContentIntent(p);
        Notification n = b.build();

        startForeground(Config.SERVER_SERVICE_ID, n);
    }

    // remove notification
    public void remove_notification() {
        stopForeground(true);
    }

    public void server_started(String ip, int port) {
        // save port
        _port = port;

        show_notification();
        // emit event
        Json event = Json.object()
            .set(Config.TYPE, Config.SERVICE_STARTED)
            .set(Config.DATA, Json.object()
                .set(Config.NAME, Config.SERVER_SERVICE)
            );
        Config.put_event(event);
    }

    public void server_closed() {
        System.err.println("DEBUG: ServerService: server closed");
        // emit event
        Json event = Json.object()
            .set(Config.TYPE, Config.SERVER_EXIT);
        Config.put_event(event);
    }

    public void thread_exit() {
        System.err.println("DEBUG: ServerService: thread exit");
        // emit event
        Json event = Json.object()
            .set(Config.TYPE, Config.SERVER_EXIT);
        Config.put_event(event);
    }

    // get / set root_key
    public String root_key() {
        return _s.root_key();
    }
    public void root_key(String key) {
        _s.root_key(key);
    }

    // get server port
    public int port() {
        return _port;
    }
}
