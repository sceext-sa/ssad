package org.sceext.ssad_server.builtin;

import mjson.Json;

import org.sceext.http_server.OneReq;
import org.sceext.ssad_server.DServer;
import org.sceext.ssad_server.OnReqBase;

import org.sceext.http_server.Server;
import org.sceext.ssad_server.DServerConfig;


//  /ssad201706/pub/.ssad/
public class BuiltinPub extends OnReqBase {

    public BuiltinPub(DServer server) {
        super(server);
    }

    @Override
    protected Json _on_req(Json info, String path) throws Exception {
        String method = info.at("method").asString();
        // check path
        if (path.equals("version")) {
            // check method
            if (! method.equals(OneReq.GET)) {
                return OneReq.res_code(405);  // HTTP 405 Method Not Allowed
            }
            return _version();
        } else if (path.equals("key")) {
            if (! method.equals(OneReq.GET)) {
                return OneReq.res_code(405);
            }
            return _key();
        } else {
            return OneReq.res_code(404);  // HTTP 404 Not Found
        }
    }

    @Override
    public Json got_post_data(byte[] data) throws Exception {
        throw new Exception("never got here");
    }

    private Json _version() {
        // TODO add more version info ?
        Json o = Json.object()
            .set("http_server", Server.VERSION)
            .set("ssad_server", DServerConfig.VERSION);
        return OneReq.res_json(o, true);
    }

    private Json _key() throws Exception {
        String o = MakeSsadKey.make();
        if (null == o) {
            return OneReq.res_code(500);
        }
        return OneReq.res_text(o + "\n");
    }
}
