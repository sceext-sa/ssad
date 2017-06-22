package org.sceext.ssad.ssad_native;

import java.util.LinkedList;

import com.facebook.react.bridge.Promise;

import mjson.Json;


public class EventCache {
    public static int DEFAULT_MAX_SIZE = 256;

    private final LinkedList<Json> _event_cache;
    private Promise _event_promise = null;

    private int _max_size;

    public EventCache() {
        _event_cache = new LinkedList<>();

        _max_size = DEFAULT_MAX_SIZE;
    }

    // get / set
    public int max_size() {
        return _max_size;
    }

    public EventCache max_size(int size) {
        _max_size = size;
        return this;
    }


    public synchronized void put_event(Json data) {
        if (_event_promise != null) {
            Json events = Json.array()
                .add(data);
            _event_promise.resolve(events.toString());
            _event_promise = null;  // reset promise
        } else {
            _event_cache.add(data);  // put event in cache
            // check max_size
            while (_event_cache.size() > _max_size) {
                // DEBUG drop event
                System.err.println("WARNING: EventCache: drop event " + _event_cache.size());
                // remove first event
                _event_cache.removeFirst();
            }
        }
    }

    public synchronized void pull_events(Promise promise) {
        if (_event_cache.size() > 0) {
            Json events = Json.make(_event_cache.toArray(new Json[0]));
            // clear cache
            _event_cache.clear();
            promise.resolve(events.toString());
        } else {
            _event_promise = promise;
        }
    }
}
