package org.sceext.ssad_server;

import java.io.File;
import java.util.Map;

import mjson.Json;

import org.sceext.http_server.OneReq;
import org.sceext.ssad_server.builtin.BuiltinKey;


public class SubRoot extends OnReqBase {
    public static final String BUILTIN_ID = ".ssad";
    public static final String SSAD_KEY = "ssad_key";

    public SubRoot(DServer server) {
        super(server);
    }

    @Override
    protected Json _on_req(Json info, String path) throws Exception {
        // SSAD_APP_ID
        int i = path.indexOf("/");  //  /ssad201706/key/SSAD_APP_ID/
        if (-1 == i) {  // error path
            return OneReq.res_code(404);  // HTTP 404 Not Found
        }
        String app_id = path.substring(0, i);
        _set_rest_path(i + 1);

        Json a = _req.req_info().at("query");
        // builtin sub_root
        if (app_id.equals(BUILTIN_ID)) {
            // check root_key
            String root_key = _server.config().root_key();
            if ((! a.has(SSAD_KEY)) || (! a.at(SSAD_KEY).asString().equals(root_key))) {
                return OneReq.res_code(403);  // key wrong !
            }
            // root_key pass
            _sub = new BuiltinKey(_server);
            return _sub.on_req(_req);
        }
        // check sub_root config
        Json app = _config().at("sub_root").at("app");
        if (! app.has(app_id)) {
            return OneReq.res_code(404);  // no such app
        }
        // check app key
        String app_key = app.at(app_id).at("key").asString();
        if ((! a.has(SSAD_KEY)) || (! a.at(SSAD_KEY).asString().equals(app_key))) {
            return OneReq.res_code(403);  // key wrong !
        }
        // normal sub_root process
        return _normal_sub_root(app_id, app.at(app_id).at("sub"), info.at("method").asString());
    }

    // use list dir format
    private Json _list_sub_root(String app_id, Json sub) {
        Json dir = Json.object();
        Map<String, Json> ss = sub.asJsonMap();
        for (Map.Entry<String, Json> s: ss.entrySet()) {
            Json one = s.getValue();
            one.set("type", "dir");
            dir.set(s.getKey(), one);
        }
        Json o = Json.object()
            .set("app_id", app_id)
            .set("dir", dir);
        return o;
    }

    // already pass ssad_key check
    private Json _normal_sub_root(String app_id, Json sub, String method) throws Exception {
        String path = _path();
        if (path.equals("")) {  //  /ssad201706/key/SSAD_APP_ID/
            // list all sub_root
            return OneReq.res_json(_list_sub_root(app_id, sub), true);
        }
        // SUB_ROOT
        int i = path.indexOf("/");  //  /ssad201706/key/SSAD_APP_ID/SUB_ROOT/PATH
        if (-1 == i) {  // error path
            return OneReq.res_code(404);
        }
        String sr = path.substring(0, i);
        _set_rest_path(i + 1);

        // check sub_root
        if (! sub.has(sr)) {
            return OneReq.res_code(404);
        }
        Json sub_root = sub.at(sr);
        Json allow = sub.at("allow");
        // check read-only
        Boolean ro = false;
        if ((allow.has("ro")) && allow.at("ro").asBoolean()) {
            ro = true;
        }

        String root_path = sub_root.at("path").asString();
        String file_path = Util.norm_path(Util.merge_path(root_path, _path()));
        if (! Util.is_path_security(root_path, file_path)) {
            // TODO print warning ?
            return OneReq.res_code(403);  // file path out of root !
        }
        // check is directory
        File f = new File(file_path);
        if (f.isDirectory()) {
            if (method.equals(OneReq.GET)) {
                // check list dir
                if ((! allow.has("list")) || (! allow.at("list").asBoolean())) {
                    return OneReq.res_code(403);  // NOT allow list dir
                }
                // list dir
                Json o = Util.list_dir(file_path);
                o.set("path", file_path);  // add path
                return OneReq.res_json(o, true);
            } else if (method.equals(OneReq.DELETE)) {
                // check delete dir
                if (ro || (! allow.has("delete")) || (! allow.at("delete").asBoolean())) {
                    return OneReq.res_code(403);  // NOT allow delete dir
                }
                Util.delete_file(file_path);
                // delete OK
                return OneReq.res_code(200);
            } else {
                return OneReq.res_code(405);  // HTTP 405 Method Not Allowed
            }
        } else {
            // process normal file
            if (method.equals(OneReq.GET) || method.equals(OneReq.HEAD_)) {
                // download file
                // TODO support mime type ?
                return OneReq.res_static_file(file_path, null);
            } else if (method.equals(OneReq.PUT)) {
                // check upload file
                if (ro || (! allow.has("put")) || (! allow.at("put").asBoolean())) {
                    return OneReq.res_code(403);  // NOT allow PUT file
                }
                // check replace file
                if (f.exists() && ((! allow.has("replace")) || (! allow.at("replace").asBoolean()))) {
                    return OneReq.res_code(403);  // NOT allow replace file
                }
                // check parent dir
                File parent = f.getParentFile();
                if (! parent.isDirectory()) {
                    // try to create dir
                    if (! parent.mkdirs()) {
                        // just error
                        throw new Exception("create parent dir " + parent.getPath());
                    }
                }
                // upload file
                return OneReq.res_upload_file(file_path);
            } else if (method.equals(OneReq.DELETE)) {
                if (! f.exists()) {
                    return OneReq.res_code(404);
                }
                // check delete file
                if (ro || (! allow.has("delete")) || (! allow.at("delete").asBoolean())) {
                    return OneReq.res_code(403);  // NOT allow delete
                }
                Util.delete_file(file_path);
                // delete OK
                return OneReq.res_code(200);
            } else {
                return OneReq.res_code(405);
            }
        }
    }
}
