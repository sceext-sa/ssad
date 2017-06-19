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

    private Thread _t;
    private ServerThread _s;

    @Override
    public void onCreate() {
        // create thread
        _s = new ServerThread(this);
        _t = new Thread(_s);
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
        _mi().service_running_server(false);
        remove_notification();
        // emit event
        Json event = Json.object()
            .set("type", "service_stopped")
            .set("name", "server_service");
        _mi().put_event(event);
    }

    // show notification (run service in foreground)
    public void show_notification() {
        // create a notification
        Intent intent = new Intent(this, MainActivity.class);
        PendingIntent p = PendingIntent.getActivity(this, 0, intent, PendingIntent.FLAG_UPDATE_CURRENT);
        NotificationCompat.Builder b = new NotificationCompat.Builder(this)
            .setSmallIcon(R.mipmap.ic_launcher)
            .setContentTitle("ssad_server is running")
            .setContentText(_s.get_info())
            .setContentIntent(p);
        Notification n = b.build();

        startForeground(Config.SERVER_SERVICE_ID, n);
    }

    // remove notification
    public void remove_notification() {
        stopForeground(true);
    }

    public void server_started() {
        show_notification();
        _mi().service_running_server(true);
        // emit event
        Json event = Json.object()
            .set("type", "service_started")
            .set("name", "server_service");
        _mi().put_event(event);
    }

    public void server_closed() {
        // TODO
    }

    public void thread_exit() {
        // TODO
    }

    private MainApplication _mi() {
        return MainApplication.instance();
    }
}
