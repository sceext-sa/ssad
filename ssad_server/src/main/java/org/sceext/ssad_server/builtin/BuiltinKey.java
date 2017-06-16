package org.sceext.ssad_server.builtin;

import java.util.Map;

import mjson.Json;

import org.sceext.http_server.OneReq;
import org.sceext.ssad_server.DServer;
import org.sceext.ssad_server.OnReqBase;


public class BuiltinKey extends OnReqBase {
    //  /ssad201706/key/.ssad/config
    private static final String _CONFIG = "config";

    private String _path;

    public BuiltinKey(DServer server) {
        super(server);
    }

    @Override
    protected Json _on_req(Json info, String path) throws Exception {
        _path = path;
        // check path
        if (path.equals(_CONFIG)) {
            return _on_config(info);
        } else {
            return OneReq.res_code(404);  // HTTP 404 Not Found
        }
    }

    @Override
    public Json got_post_data(byte[] data) throws Exception {
        // check path
        if (_path.equals(_CONFIG)) {
            return _on_config(data);
        } else {
            throw new Exception("never got here");
        }
    }

    private Json _on_config(Json info) throws Exception {
        String method = info.at(OneReq.METHOD).asString();
        // check method
        if (method.equals(OneReq.GET)) {
            // res config json (ssad_server runtime config)
            Json config = _config();
            return OneReq.res_json(config, true);
        } else if (method.equals(OneReq.POST)) {
            return OneReq.get_post_data();  // allow POST
        } else {
            return OneReq.res_code(405);  // HTTP 405 Method Not Allowed
        }
    }

    // on POST
    private Json _on_config(byte[] data) throws Exception {
        Json r = null;  // req: POST json body
        // try parse json, and check json format
        try {
            String text = new String(data, "utf-8");
            r = Json.read(text);
        } catch (Exception e) {
            e.printStackTrace();
            Json t = Json.object()
                .set("error", "parse json text");
            return OneReq.res_json(t, true);
        }
        if ((null == r) || (! r.isObject())) {
            Json t = Json.object()
                .set("error", "bad json format");
            return OneReq.res_json(t, true);
        }
        // try merge new config
        Json config = _config();
        Map<String, Json> m = r.asJsonMap();
        for (Map.Entry<String, Json> e: m.entrySet()) {
            config.set(e.getKey(), e.getValue());
        }
        // set to DServerConfig
        _server.config().config(config);
        // OK
        return OneReq.res_code(200);
    }
}
