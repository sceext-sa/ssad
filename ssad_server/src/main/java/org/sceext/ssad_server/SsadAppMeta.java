package org.sceext.ssad_server;

import java.io.File;

import mjson.Json;

import org.sceext.http_server.OneReq;


public class SsadAppMeta {
    private final String _app_id;
    private Json _meta;
    // req_info
    private Json _info;
    // ssad_server runtime (json) config
    private Json _config;

    private Json _sub_root;
    private Json _pub_root;

    public SsadAppMeta(String app_id, String file_path) throws Exception {
        _app_id = app_id;
        // load ssad_app.meta.json
        _meta = Util.load_json(file_path);
        if (null == _meta) {
            throw new Exception("load " + file_path);
        }
        // TODO check `ssad_app_spec` ?
    }

    public Json meta() {
        return _meta;
    }

    public void info(Json i) {
        _info = i;
    }

    public void config(Json c) {
        _config = c;
    }

    public String main() {
        return _meta.at("main").asString();
    }

    // pub_root redirect (main)
    public String pub_root_redirect() {
        //  /ssad201706/pub/SSAD_APP_ID/
        String full_path = _info.at(OneReq.FULL_URL).asString();
        int i = full_path.indexOf(OneReq.QM);
        if (i != -1) {
            full_path = full_path.substring(0, i);
        }
        // redirect location
        return full_path + main();
    }

    public Json pub_root(String pr) {
        if (! _meta.has("pub_root")) {
            return null;
        }
        if (! _meta.at("pub_root").has(pr)) {
            return null;
        }
        return _meta.at("pub_root").at(pr);
    }

    public boolean has_pub_root(String pr) {
        _pub_root = pub_root(pr);
        if (null == _pub_root) {
            return false;
        }
        return true;
    }

    public Json sub_root(Json pr) {
        // check sub_root
        String sr = pr.at("sub_root").asString();
        Json app = _config.at("sub_root").at("app");
        if (! app.has(_app_id)) {
            return null;  // no such app in sub_root
        }
        Json sub = app.at(_app_id).at("sub");
        if (! sub.has(sr)) {
            return null;  // no such sub_root
        }
        return sub.at(sr);
    }

    public boolean has_sub_root() {
        _sub_root = sub_root(_pub_root);
        if (null == _sub_root) {
            return false;
        }
        return true;
    }

    public String file_path(String path) throws Exception {
        // make file_path
        String file_root = _sub_root.at("path").asString();
        String file_path = Util.merge_path(file_root, _pub_root.at("path").asString(), path);
        // check path security
        if (! Util.is_path_security(file_root, file_path)) {
            // TODO print warning ?
            return null;
        }
        // absolute file path
        return Util.norm_path(file_path);
    }

    public Json mime_header(String file_path) {
        // get file ext
        String name = new File(file_path).getName();
        String ext = "";
        int i = name.lastIndexOf(".");
        if (i != -1) {
            ext = name.substring(i + 1);
        }
        // check mime type
        if (! _meta.has("ext_to_mime")) {
            return null;  // no mime type info
        }
        Json to = _meta.at("ext_to_mime");
        String mime = "application/octet-stream";
        if (to.has(ext)) {
            mime = to.at(ext).asString();
        } else if (to.has("")) {
            mime = to.at("").asString();  // default type
        }
        Json o = Json.object()
            .set("Content-Type", mime);
        return o;
    }

    // check allow list dir
    public boolean is_allow_list() {
        // check pub_root config allow list
        if (! _pub_root.has("allow")) {
            return false;
        }
        Json allow = _pub_root.at("allow");
        if ((! allow.has("list")) || (! allow.at("list").asBoolean())) {
            return false;
        }
        // check sub_root config allow list
        if (! _sub_root.has("allow")) {
            return false;
        }
        allow = _sub_root.at("allow");
        if ((! allow.has("list")) || (! allow.at("list").asBoolean())) {
            return false;
        }
        return true;
    }
}
