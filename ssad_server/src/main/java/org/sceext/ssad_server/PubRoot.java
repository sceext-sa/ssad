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
        if (path.equals("")) {  //  /ssad201706/pub/
            // TODO list SSAD_APP_ID ? (list dir)
            return OneReq.res_code(404);  // HTTP 404 Not Found
        }
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
        // load ssad_app.meta.json
        Json meta = Util.load_json(app_meta);
        if (null == meta) {
            return OneReq.res_code(500);  // server error
        }
        // TODO check `ssad_app_spec` ?

        String path = _path();
        if (path.equals("")) {  //  /ssad201706/pub/SSAD_APP_ID/
            // pub_root redirect (main)
            String full_path = _req.req_info().at(OneReq.FULL_URL).asString();
            int i = full_path.indexOf(OneReq.QM);
            if (i != -1) {
                full_path = full_path.substring(0, i);
            }
            String location = full_path + meta.at("main").asString();
            return OneReq.res_redirect(location);
        }
        // PUB_ROOT
        int i = path.indexOf("/");  //  /ssad201706/pub/SSAD_APP_ID/PUB_ROOT/PATH
        if (-1 == i) {  // error path
            return OneReq.res_code(404);
        }
        String pr = path.substring(0, i);
        _set_rest_path(i + 1);

        // check pub_root
        if ((! meta.has("pub_root")) || (! meta.at("pub_root").has(pr))) {
            return OneReq.res_code(404);  // no such pub root
        }
        Json pub_root = meta.at("pub_root").at(pr);
        // check sub_root
        String sr = pub_root.at("sub_root").asString();
        Json app = _config().at("sub_root").at("app");
        if (! app.has(app_id)) {
            return OneReq.res_code(403);  // no such app in sub_root
        }
        Json sub = app.at(app_id).at("sub");
        if (! sub.has(sr)) {
            return OneReq.res_code(403);  // no such sub_root
        }
        Json sub_root = sub.at(sr);
        // make file_path
        String file_root = sub_root.at("path").asString();
        String file_path = Util.merge_path(file_root, pub_root.at("path").asString(), _path());
        if (! Util.is_path_security(file_root, file_path)) {
            // TODO print error ?
            return OneReq.res_code(404);  // file path out of root !
        }

        // check is directory
        File f = new File(file_path);
        if (f.isDirectory()) {
            // check allow list
            if (_is_allow_list(pub_root, sub_root)) {
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
            // TODO FIXME set MIME-type ?
            return OneReq.res_static_file(file_path, null);
        }
    }

    // check allow list dir
    private boolean _is_allow_list(Json pub_root, Json sub_root) {
        // check pub_root config allow list
        if (! pub_root.has("allow")) {
            return false;
        }
        Json allow = pub_root.at("allow");
        if ((! allow.has("list")) || (! allow.at("list").asBoolean())) {
            return false;
        }
        // check sub_root config allow list
        if (! sub_root.has("allow")) {
            return false;
        }
        allow = sub_root.at("allow");
        if ((! allow.has("list")) || (! allow.at("list").asBoolean())) {
            return false;
        }
        return true;
    }
}
