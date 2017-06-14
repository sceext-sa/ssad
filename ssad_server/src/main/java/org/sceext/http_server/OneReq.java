// TODO
package org.sceext.http_server;

import java.io.File;
import java.io.FileOutputStream;
import java.io.RandomAccessFile;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.LinkedList;
import java.util.Locale;
import java.util.Map;
import java.util.TimeZone;

import io.netty.buffer.Unpooled;
import io.netty.channel.ChannelFuture;
import io.netty.channel.ChannelFutureListener;
import io.netty.channel.DefaultFileRegion;
import io.netty.handler.codec.http.DefaultFullHttpResponse;
import io.netty.handler.codec.http.DefaultHttpResponse;
import io.netty.handler.codec.http.FullHttpResponse;
import io.netty.handler.codec.http.HttpResponse;
import io.netty.handler.codec.http.HttpHeaderNames;
import io.netty.handler.codec.http.HttpHeaderValues;
import io.netty.handler.codec.http.HttpHeaders;
import io.netty.handler.codec.http.HttpMethod;
import io.netty.handler.codec.http.HttpResponseStatus;
import io.netty.handler.codec.http.HttpVersion;
import io.netty.handler.codec.http.LastHttpContent;
import io.netty.util.CharsetUtil;

import mjson.Json;

import org.sceext.json.JsonPretty;


public class OneReq {
    // static string
    public static final String CODE = "code";
    public static final String FULL_URL = "full_url";
    public static final String GET = "GET";
    public static final String GET_POST_DATA = "get_post_data";
    public static final String HEAD = "head";
    public static final String HEADER = "header";
    public static final String HTTP_VERSION = "http_version";
    public static final String JSON = "json";
    public static final String LOCATION = "location";
    public static final String METHOD = "method";
    public static final String PATH = "path";
    public static final String PRETTY_PRINT = "pretty_print";
    public static final String QUERY = "query";
    public static final String REDIRECT = "redirect";
    public static final String STATIC_FILE = "static_file";
    public static final String TEXT = "text";
    public static final String TYPE = "type";
    public static final String UPLOAD_FILE = "upload_file";

    public static final String QM = "?";  // question mark

    // HTTP 301 Moved Permanently
    // HTTP 302 Found
    // HTTP 307 Temporary Redirect
    // HTTP 308 Permanent Redirect
    public static final int DEFAULT_REDIRECT_CODE = 302;
    // http `Server:` header
    public static String SERVER_NAME = "sceext.netty_http_server v0.1";
    public static String UPLOAD_FILE_TMP_SUFFIX = ".tmp";

    // private attr
    private final NettyHandler _h;
    private final IReqCallback _callback;
    private final IOnReq _on_req;

    private boolean _is_end = false;  // set to `true` after `_on_end()`
    private boolean _is_get_post_data = false;  // set to `true` when start get post data
    private List<byte[]> _cache;  // cached post data

    private Json _req_info;

    // for file upload
    private boolean _is_upload_file = false;  // is `doing` file upload
    private String _upload_file_path;
    private String _upload_tmp_file_path;
    private FileOutputStream _upload_file;  // write data to this tmp file

    public OneReq(NettyHandler h, IReqCallback callback) {
        _h = h;
        _callback = callback;

        // create on_req object
        _on_req = _callback.create_on_req();
        // create cache
        _cache = new LinkedList<byte[]>();
    }

    // get / set

    public Json req_info() {
        return _req_info;
    }

    public void req_info(Json i) {
        _req_info = i;
    }

    // public methods used by IOnReq

    // for quick build res

    public static Json res_code(int code) {
        Json o = Json.object();
        o.set(TYPE, CODE);
        o.set(CODE, code);
        return o;
    }

    public static Json res_text(String text) {
        Json o = Json.object();
        o.set(TYPE, TEXT);
        o.set(TEXT, text);
        return o;
    }

    public static Json res_text(String text, Json header) {
        Json o = res_text(text);
        o.set(HEADER, header);
        return o;
    }

    public static Json res_json(Json json, boolean pretty_print) {
        Json o = Json.object();
        o.set(TYPE, JSON);
        o.set(JSON, json);
        o.set(PRETTY_PRINT, pretty_print);
        return o;
    }

    public static Json res_json(Json json, boolean pretty_print, Json header) {
        Json o = res_json(json, pretty_print);
        o.set(HEADER, header);
        return o;
    }

    public static Json res_redirect(String location) {
        Json o = Json.object();
        o.set(TYPE, REDIRECT);
        o.set(REDIRECT, location);
        return o;
    }

    public static Json res_redirect(String location, int code) {
        Json o = res_redirect(location);
        o.set(CODE, code);
        return o;
    }

    public static Json res_static_file(String file_path, Json header) {
        Json o = Json.object();
        o.set(TYPE, STATIC_FILE);
        o.set(PATH, file_path);
        o.set(HEADER, header);
        return o;
    }

    public static Json res_upload_file(String file_path) {
        Json o = Json.object();
        o.set(TYPE, UPLOAD_FILE);
        o.set(PATH, file_path);
        return o;
    }

    public static Json get_post_data() {
        Json o = Json.object();
        o.set(TYPE, GET_POST_DATA);
        return o;
    }

    // public methods used by NettyHandler

    public void _call_on_req() {
        try {
            _add_path();

            Json res = _on_req.on_req(this);
            _req_res(res, false);
        } catch (Exception e) {
            e.printStackTrace();
            _res_code(500);
        }
    }

    // recv post data
    public void _on_post_data(byte[] data) {
        // check for upload file
        if (_is_upload_file) {
            _upload_file_data(data);
        } else {  // for get_post_data
            // add data to cache
            _cache.add(data);
        }
    }

    // on LastHttpContent
    public void _on_end() {
        _is_end = true;

        if (_is_get_post_data) {
            _got_post_data();
        } else if (_is_upload_file) {
            _upload_file_end();
        }
    }

    public void _channel_read_complete() {
        // TODO
    }

    public void _send_code(int code) {
        _res_code(code);
    }

    // private methods

    // add `.path` from _req_info.full_url
    private void _add_path() {
        String full = _req_info.at(FULL_URL).asString();
        int i = full.indexOf(QM);
        if (i != -1) {
            _req_info.set(PATH, full.substring(0, i));
        } else {
            _req_info.set(PATH, full);
        }
    }

    // res Json info return by `_on_req.on_req()`
    private void _req_res(Json res, boolean post_worker) throws Exception {
        String type = res.at(TYPE).asString();
        // check res type
        if (type.equals(CODE)) {
            int code = res.at(CODE).asInteger();
            _res_code(code);
        } else if (type.equals(TEXT)) {
            String text = res.at(TEXT).asString();
            _res_text(text, res.at(HEADER));
        } else if (type.equals(JSON)) {
            Json json = res.at(JSON);
            String text = "";
            if (res.has(PRETTY_PRINT) && res.at(PRETTY_PRINT).asBoolean()) {
                text = JsonPretty.print(json);
            } else {
                text = json.toString();
            }
            if (! res.has(HEADER)) {
                res.set(HEADER, Json.object());
            }
            // set `Content-Type: application/json`
            res.at(HEADER).set(HttpHeaderNames.CONTENT_TYPE.toString(), HttpHeaderValues.APPLICATION_JSON.toString());
            _res_text(text, res.at(HEADER));
        } else if (type.equals(REDIRECT)) {
            String location = res.at(REDIRECT).asString();
            int code = DEFAULT_REDIRECT_CODE;
            if (res.has(CODE)) {
                code = res.at(CODE).asInteger();
            }
            _res_redirect(location, code);
        } else if (type.equals(STATIC_FILE)) {
            String file_path = res.at(PATH).asString();
            _res_static_file(file_path, res.at(HEADER));
        } else if (type.equals(UPLOAD_FILE)) {
            // can not use in `post_worker`
            if (post_worker) {
                throw new Exception("`upload_file` can not use in post worker");
            }
            String file_path = res.at(PATH).asString();
            _upload_file(file_path, UPLOAD_FILE_TMP_SUFFIX);
        } else if (type.equals(GET_POST_DATA)) {
            // can not use in `post_worker`
            if (post_worker) {
                throw new Exception("`get_post_data` can not use in post worker");
            }
            _get_post_data();
        } else {
            throw new Exception("unknow res.type " + type);
        }
    }

    private void _res_code(int code) {
        String text = "HTTP " + code + " " + HttpResponseStatus.valueOf(code).reasonPhrase() + "\n";
        _send_res(code, text, null);
    }

    // HTTP 200 OK
    private void _res_text(String text, Json header) {
        if (null == header) {
            header = Json.object();
        }
        // check and set `Content-Type`
        if (! header.has(HttpHeaderNames.CONTENT_TYPE.toString())) {
            header.set(HttpHeaderNames.CONTENT_TYPE.toString(), HttpHeaderValues.TEXT_PLAIN.toString());
        }
        _send_res(200, text, header);
    }

    private void _res_redirect(String location, int code) {
        FullHttpResponse res = new DefaultFullHttpResponse(HttpVersion.HTTP_1_1, HttpResponseStatus.valueOf(code));
        HttpHeaders h = res.headers();
        h.set(HttpHeaderNames.LOCATION, location);
        // send res
        _h.ctx().writeAndFlush(res);
        _check_keep_alive();
    }

    private void _check_keep_alive() {
        if (_h.is_keep_alive()) {
            _h.ctx().writeAndFlush(Unpooled.EMPTY_BUFFER).addListener(ChannelFutureListener.CLOSE);
        }
    }

    private void _set_headers(HttpHeaders h, Json header) {
        final String DATE_FORMAT = "EEE, dd MMM yyyy HH:mm:ss zzz";
        final String DATE_GMT = "GMT";
        // set `Date` header
        SimpleDateFormat df = new SimpleDateFormat(DATE_FORMAT, Locale.US);
        df.setTimeZone(TimeZone.getTimeZone(DATE_GMT));
        Calendar time = new GregorianCalendar();
        h.set(HttpHeaderNames.DATE, df.format(time.getTime()));

        // set `Connection: keep-alive`
        if (_h.is_keep_alive()) {
            h.set(HttpHeaderNames.CONNECTION, HttpHeaderValues.KEEP_ALIVE);
        }
        // set `Server` header
        h.set(HttpHeaderNames.SERVER, SERVER_NAME);
        // set custom headers
        if (header != null) {
            Map<String, Json> headers = header.asJsonMap();
            for(Map.Entry<String, Json> p: headers.entrySet()) {
                h.set(p.getKey(), p.getValue().asString());
            }
        }
    }

    // will set `Server` and `Content-Length` headers
    private void _send_res(int code, String text, Json header) {
        FullHttpResponse res = new DefaultFullHttpResponse(HttpVersion.HTTP_1_1, HttpResponseStatus.valueOf(code), Unpooled.copiedBuffer(text, CharsetUtil.UTF_8));
        HttpHeaders h = res.headers();
        // set `Content-Length` headers, and custom headers
        h.setInt(HttpHeaderNames.CONTENT_LENGTH, res.content().readableBytes());
        _set_headers(h, header);
        // send res
        _h.ctx().writeAndFlush(res);
        _check_keep_alive();
    }

    private String _make_last_modified(File f) {
        final String DATE_FORMAT = "EEE, dd MMM yyyy HH:mm:ss zzz";
        final String DATE_GMT = "GMT";

        SimpleDateFormat df = new SimpleDateFormat(DATE_FORMAT, Locale.US);
        df.setTimeZone(TimeZone.getTimeZone(DATE_GMT));

        String last = df.format(new Date(f.lastModified()));
        return last;
    }

    // TODO support check MIME-type ?
    // TODO support `Range:` header
    private void _res_static_file(String file_path, Json header) throws Exception {
        // check request method
        String method = _req_info.at(METHOD).asString();
        if ((! method.equals(GET)) && (! method.equals(HEAD))) {
            _res_code(405);  // HTTP 405 Method Not Allowed
            return;
        }
        // check file exist (and is normal file)
        File f = new File(file_path);
        if ((! f.exists()) || (! f.isFile())) {
            _res_code(404);  // HTTP 404 Not Found
            return;
        }
        // make `last-modified`
        String last_modified = _make_last_modified(f);
        // check `if-modified-since`
        String if_modified_since = null;
        if (_req_info.at(HEADER).has(HttpHeaderNames.IF_MODIFIED_SINCE.toString())) {
            if_modified_since = _req_info.at(HEADER).at(HttpHeaderNames.IF_MODIFIED_SINCE.toString()).asString();
        }
        if ((if_modified_since != null) && if_modified_since.equals(last_modified)) {
            _res_code(304);  // HTTP 304 Not Modified
            return;
        }
        // get file size
        long file_size = f.length();
        // set res headers
        if (null == header) {
            header = Json.object();
        }
        header.set(HttpHeaderNames.LAST_MODIFIED.toString(), last_modified);
        header.set(HttpHeaderNames.CONTENT_LENGTH.toString(), file_size + "");

        int code = 200;  // HTTP 200 OK
        // check HEAD method
        if (method.equals(HEAD)) {
            FullHttpResponse res = new DefaultFullHttpResponse(HttpVersion.HTTP_1_1, HttpResponseStatus.valueOf(code));
            _set_headers(res.headers(), header);
            // send res
            _h.ctx().writeAndFlush(res);
            _check_keep_alive();
            return;
        }
        // res the whole file
        // FIXME file should not not exist
        RandomAccessFile ra = new RandomAccessFile(f, "r");

        HttpResponse res = new DefaultHttpResponse(HttpVersion.HTTP_1_1, HttpResponseStatus.valueOf(code));
        _set_headers(res.headers(), header);

        _h.ctx().write(res);  // res header
        // res content
        _h.ctx().write(new DefaultFileRegion(ra.getChannel(), 0, ra.length()));
        // end marker
        ChannelFuture last_content = _h.ctx().writeAndFlush(LastHttpContent.EMPTY_LAST_CONTENT);
        // check keep_alive
        if (! _h.is_keep_alive()) {
            last_content.addListener(ChannelFutureListener.CLOSE);
        }
    }

    private void _upload_file(String file_path, String tmp_suffix) throws Exception {
        _upload_file_path = file_path;
        _upload_tmp_file_path = file_path + tmp_suffix;
        // NOTE here will not create parent dir of the file
        // init file upload
        File f = new File(_upload_tmp_file_path);
        // write data to tmp file
        _upload_file = new FileOutputStream(f);
        // write any cached data
        byte[] data = _concat_cache();
        _cache = null;  // clear cache

        _upload_file.write(data);

        _is_upload_file = true;
        // check is already end
        if (_is_end) {
            _upload_file_end();
        } else {
            // start recv post data
            _h.get_post_data();
        }
    }

    private void _upload_file_data(byte[] data) {
        try {
            _upload_file.write(data);
        } catch (Exception e) {
            _upload_file_err(e);
        }
    }

    private void _upload_file_end() {
        _is_upload_file = false;
        // sync and close file
        try {
            _upload_file.flush();
            _upload_file.close();
        } catch (Exception e) {
            _upload_file_err(e);
            return;
        }
        // move file
        File tmp_f = new File(_upload_tmp_file_path);
        File f = new File(_upload_file_path);
        if (! tmp_f.renameTo(f)) {
            // FIXME improve log
            // DEBUG rename error
            System.err.println("ERROR: upload file: rename " + _upload_tmp_file_path + " -> " + _upload_file_path);

            _res_code(500);
            return;
        }
        // FIXME improve res ?
        // res HTTP 200 OK
        _res_code(200);
    }

    private void _upload_file_err(Throwable cause) {
        cause.printStackTrace();
        _res_code(500);
    }

    private void _get_post_data() {
        // check is already end
        if (_is_end) {
            _got_post_data();
        } else {
            // start get post data
            _is_get_post_data = true;
            _h.get_post_data();
        }
    }

    private byte[] _concat_cache() {
        // TODO improve concat
        byte[][] cache = _cache.toArray(new byte[0][]);
        int len = 0;
        for (int i = 0; i < cache.length; i += 1) {
            len += cache[i].length;
        }
        byte[] data = new byte[len];
        int k = 0;
        for (int i = 0; i < cache.length; i += 1) {
            for (int j = 0; j < cache[i].length; j += 1, k += 1) {
                data[k] = cache[i][j];
            }
        }
        return data;
    }

    private void _got_post_data() {
        _is_get_post_data = false;

        byte[] data = _concat_cache();
        _cache = null;  // clear cache

        // run POST process in a new thread
        new Thread(new PostWorker(data)).start();
    }

    // POST worker thread
    class PostWorker implements Runnable {
        private byte[] _data;

        public PostWorker(byte[] data) {
            _data = data;
        }

        @Override
        public void run() {
            try {
                _run();
            } catch (Exception e) {
                e.printStackTrace();
                _res_code(500);
            }
        }

        private void _run() throws Exception {
            Json res = _on_req.got_post_data(_data);
            _req_res(res, true);
        }
    }
}
