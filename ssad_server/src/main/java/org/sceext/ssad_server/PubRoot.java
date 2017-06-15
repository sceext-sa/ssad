package org.sceext.ssad_server;

import java.io.File;

import mjson.Json;

import org.sceext.http_server.OneReq;
import org.sceext.ssad_server.builtin.BuiltinPub;


public class PubRoot extends OnReqBase {
    public static final String BUILTIN_ID = ".ssad";

    public PubRoot(DServer server) {
        super(server);
    }

    @Override
    protected Json _on_req(Json info, String path) throws Exception {
        // SSAD_APP_ID
        int i = path.indexOf("/");  //  /ssad201706/pub/SSAD_APP_ID/
        if (-1 == i) {  // error path
            return OneReq.res_code(404);
        }
        String app_id = path.substring(0, i);
        _set_rest_path(i + 1);

        // builtin pub_root
        if (app_id.equals(BUILTIN_ID)) {
            _sub = new BuiltinPub(_server);
            return _sub.on_req(_req);
        }
        // check pub_root config
        Json app = _config().at("pub_root").at("app");
        if (! app.has(app_id)) {
            return OneReq.res_code(404);  // no such app
        }
        // ssad_app.meta.json
        String app_meta = app.at(app_id).at("app_meta").asString();
        return _normal_pub_root(app_id, app_meta);
    }

    // normal pub_root process
    private Json _normal_pub_root(String app_id, String app_meta) throws Exception {
        SsadAppMeta meta = new SsadAppMeta(app_id, app_meta);
        meta.info(_req.req_info());
        meta.config(_config());

        String path = _path();
        if (path.equals("")) {  //  /ssad201706/pub/SSAD_APP_ID/
            return OneReq.res_redirect(meta.pub_root_redirect());
        }
        // PUB_ROOT
        int i = path.indexOf("/");  //  /ssad201706/pub/SSAD_APP_ID/PUB_ROOT/PATH
        if (-1 == i) {  // error path
            return OneReq.res_code(404);
        }
        String pr = path.substring(0, i);
        _set_rest_path(i + 1);

        // check pub_root / sub_root
        if (! meta.has_pub_root(pr)) {
            return OneReq.res_code(404);  // no such pub_root
        }
        if (! meta.has_sub_root()) {
            return OneReq.res_code(403);  // no such sub_root
        }

        String file_path = meta.file_path(_path());
        if (null == file_path) {
            return OneReq.res_code(404);  // file path out of root !
        }

        // check is directory
        File f = new File(file_path);
        if (f.isDirectory()) {
            // check allow list
            if (meta.is_allow_list()) {
                // check method
                String method = _req.req_info().at(OneReq.METHOD).asString();
                if (! method.equals(OneReq.GET)) {
                    return OneReq.res_code(405);  // HTTP 405 Method Not Allowed
                }
                return OneReq.res_json(Util.list_dir(file_path), true);
            } else {  // NOT allow list
                return OneReq.res_code(404);
            }
        } else {
            // serve normal file
            return OneReq.res_static_file(file_path, meta.mime_header(file_path));
        }
    }
}
