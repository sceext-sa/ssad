
import java.io.File;

import mjson.Json;

import org.sceext.http_server.IOnReq;
import org.sceext.http_server.IReqCallback;
import org.sceext.http_server.OneReq;
import org.sceext.http_server.Server;

public class App {

    private static class OnReq implements IOnReq {
        private OneReq _req;

        @Override
        public Json on_req(OneReq req) throws Exception {
            _req = req;
            Json info = req.req_info();
            Json o = Json.object();

            String path = info.at("path").asString();
            if (path.equals("/")) {
                o.set("type", "redirect");
                o.set("location", "/test_get");
            } else if (path.equals("/test_get")) {
                String method = info.at("method").asString();
                if (method.equals("GET")) {
                    o.set("type", "json");
                    o.set("json", info);
                    o.set("pretty_print", true);
                } else {
                    o.set("type", "code");
                    o.set("code", 405);
                }
            } else if (path.equals("/test_post")) {
                String method = info.at("method").asString();
                if (method.equals("GET")) {
                    o.set("type", "text");
                    o.set("text", "Please use POST method\n");
                } else if (method.equals("POST")) {
                    o.set("type", "get_post_data");
                } else {
                    o.set("type", "code");
                    o.set("code", 405);
                }
            } else if (path.equals("/test_download")) {
                _download_file(info, o);
            } else if (path.equals("/test_upload")) {
                _upload_file(info, o);
            } else {
                o.set("type", "code");
                o.set("code", 404);
            }
            return o;
        }

        @Override
        public Json got_post_data(byte[] data) throws Exception {
            Json info = _req.req_info();
            Json o = Json.object();

            String path = info.at("path").asString();
            if (path.equals("/test_post")) {
                String post_text = new String(data, "utf-8");

                o.set("type", "text");
                o.set("text", "POST text: " + post_text + "\n");
            } else {
                o.set("type", "code");
                o.set("code", 405);
            }
            return o;
        }

        private void _download_file(Json info, Json o) throws Exception {
            // check path
            if (! info.at("query").has("path")) {
                o.set("type", "text");
                o.set("text", "Please set `path` \n");
                return;
            }
            String path = info.at("query").at("path").asString();
            // process root_path
            String raw_root_path = "tmp";  // dir: ./tmp
            File root = new File(raw_root_path);
            String root_path = root.getCanonicalFile().getAbsolutePath();

            File to_get = new File(root, path);
            String file_path = to_get.getCanonicalFile().getAbsolutePath();
            // DEBUG
            System.out.println("DEBUG: root_path = `" + root_path + "`, file_path = `" + file_path + "` ");
            // security check
            if (! file_path.startsWith(root_path)) {
                System.out.println("WARNING: file_path out of root_path ! ");
                o.set("type", "code");
                o.set("code", 404);  // HTTP 404 Not Found
            } else {
                // TODO set `Content-Type`
                // check pass
                o.set("type", "static_file");
                o.set("path", file_path);
            }
        }

        private void _upload_file(Json info, Json o) throws Exception {
            // check method
            String method = info.at("method").asString();
            if (method.equals("GET")) {
                o.set("type", "text");
                o.set("text", "Please use POST method \n");
                return;
            }
            if (! method.equals("POST")) {
                o.set("type", "code");
                o.set("code", 405);  // HTTP 405 Method Not Allowed
                return;
            }
            // check path
            if (! info.at("query").has("path")) {
                o.set("type", "text");
                o.set("text", "Please set `path` \n");
                return;
            }
            String path = info.at("query").at("path").asString();
            // process root_path
            String raw_root_path = "tmp";  // dir: ./tmp
            File root = new File(raw_root_path);
            String root_path = root.getCanonicalFile().getAbsolutePath();

            File to_upload = new File(root, path);
            String file_path = to_upload.getCanonicalFile().getAbsolutePath();
            // security check
            if (! file_path.startsWith(root_path)) {
                System.out.println("WARNING: file_path out of root_path ! " + root_path + " -> " + file_path);
                o.set("type", "code");
                o.set("code", 404);  // HTTP 404 Not Found
                return;
            }
            // check parent dir
            File parent = to_upload.getParentFile();
            if (! parent.isDirectory()) {
                // DEBUG
                System.out.println("WARNING: parent dir not exist ! " + parent.getCanonicalFile().getAbsolutePath());
                // try to create dir
                if (! parent.mkdirs()) {
                    System.out.println("ERROR: can not create dir " + parent.getCanonicalFile().getAbsolutePath());
                    o.set("type", "code");
                    o.set("code", 404);  // HTTP 404 Not Found
                    return;
                }
            }
            // do upload
            o.set("type", "upload_file");
            o.set("path", file_path);
        }
    }

    private static class Callback implements IReqCallback {
        @Override
        public IOnReq create_on_req() {
            return new OnReq();
        }

        @Override
        public void on_listen(String ip, int port) {
            // TODO
        }

        @Override
        public void on_close() {
            // TODO
        }
    }

    public static void main(String[] args) throws Exception {
        Server s = new Server(new Callback());
        s.run();
    }
}
