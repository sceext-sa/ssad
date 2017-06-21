package org.sceext.ssad;

import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.Service;
import android.content.ClipboardManager;
import android.content.ClipData;
import android.content.Context;
import android.content.Intent;
import android.os.IBinder;

import android.support.v4.app.NotificationCompat;

import mjson.Json;

import org.sceext.ssad.ssad_native.Config;
import org.sceext.ssad.ssad_native.ClipLog;


public class ClipService extends Service {
    private boolean _running = false;

    private ClipboardManager _m;
    private ClipboardManager.OnPrimaryClipChangedListener _listener;
    private String _clip_text;

    @Override
    public void onCreate() {
        _m = (ClipboardManager) getSystemService(Context.CLIPBOARD_SERVICE);
        _listener = new ClipboardManager.OnPrimaryClipChangedListener() {
            @Override
            public void onPrimaryClipChanged() {
                _log_clip();
            }
        };
        // save service in config
        Config.i().clip_service(this);
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        if (_running) {
            // WARNING
            System.err.println("ClipService: WARNING: start service while already running ");
            return START_NOT_STICKY;
        }
        // start watch clip
        _watch_clip();
        // log once at its start
        _log_clip();
        // show notification
        show_notification();

        _running = true;  // set running flag
        // emit event
        Json event = Json.object()
            .set(Config.TYPE, Config.SERVICE_STARTED)
            .set(Config.DATA, Json.object()
                .set(Config.NAME, Config.CLIP_SERVICE)
            );
        Config.put_event(event);

        return START_NOT_STICKY;
    }

    @Override
    public IBinder onBind(Intent intent) {
        return null;  // not allow bind
    }

    @Override
    public void onDestroy() {
        // stop watch clip
        _stop_watch();

        // remove this from config
        Config.i().clip_service(null);

        remove_notification();
        // emit event
        Json event = Json.object()
            .set(Config.TYPE, Config.SERVICE_STOPPED)
            .set(Config.DATA, Json.object()
                .set(Config.NAME, Config.CLIP_SERVICE)
            );
        Config.put_event(event);
    }

    // show notification (run service in foreground)
    public void show_notification() {
        startForeground(Config.CLIP_SERVICE_ID, _create_notification());
    }

    private Notification _create_notification() {
        Intent intent = new Intent(this, ClipActivity.class);
        PendingIntent p = PendingIntent.getActivity(this, 0, intent, PendingIntent.FLAG_UPDATE_CURRENT);
        NotificationCompat.Builder b = new NotificationCompat.Builder(this)
            .setSmallIcon(R.mipmap.ic_launcher)
            .setContentTitle("SSAD clip")
            .setContentText(_clip_text)
            .setContentIntent(p);
        return b.build();
    }

    private void _update_notification() {
        NotificationManager m = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
        m.notify(Config.CLIP_SERVICE_ID, _create_notification());
    }

    // remove notification
    public void remove_notification() {
        stopForeground(true);
    }

    private void _watch_clip() {
        // add listener
        _m.addPrimaryClipChangedListener(_listener);
    }

    private void _stop_watch() {
        // remove listener
        _m.removePrimaryClipChangedListener(_listener);
    }

    private void _log_clip() {
        ClipData d = _m.getPrimaryClip();
        if (null == d) {
            return;
        }
        ClipData.Item item = d.getItemAt(0);
        boolean is_text = true;
        CharSequence s = item.getText();
        if (null == s) {
            is_text = false;
            s = item.coerceToText(this);
        }
        _clip_text = s.toString();
        // log it
        ClipLog.log(_clip_text, is_text);

        _update_notification();
        // clip changed event
        Json event = Json.object()
            .set(Config.TYPE, Config.CLIP_CHANGED);
        Config.put_event(event);
    }
}
