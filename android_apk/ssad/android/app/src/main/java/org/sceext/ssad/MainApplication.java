package org.sceext.ssad;

import java.util.Arrays;
import java.util.List;

import android.app.Application;

import com.facebook.react.ReactApplication;
import com.facebook.react.ReactNativeHost;
import com.facebook.react.ReactPackage;
import com.facebook.react.shell.MainReactPackage;
import com.facebook.soloader.SoLoader;

import mjson.Json;

import org.sceext.ssad.ssad_native.SsadNative;


public class MainApplication extends Application implements ReactApplication {

  private final ReactNativeHost mReactNativeHost = new ReactNativeHost(this) {
    @Override
    public boolean getUseDeveloperSupport() {
      return BuildConfig.DEBUG;
    }

    @Override
    protected List<ReactPackage> getPackages() {
      return Arrays.<ReactPackage>asList(
          new MainReactPackage(),
          new SsadPackage()
      );
    }
  };

  @Override
  public ReactNativeHost getReactNativeHost() {
    return mReactNativeHost;
  }

  @Override
  public void onCreate() {
    super.onCreate();
    SoLoader.init(this, /* native exopackage */ false);

    // save instance
    _instance = this;
  }

    // TODO FIXME improve following code (clean)

    // global data
    private static MainApplication _instance = null;

    public static MainApplication instance() {
        return _instance;
    }

    private String _webview_url;
    // get / set
    public String webview_url() {
        return _webview_url;
    }
    public MainApplication webview_url(String url) {
        _webview_url = url;
        return this;
    }

    private boolean _service_running_server = false;
    private boolean _service_running_clip = false;
    public boolean service_running_server() {
        return _service_running_server;
    }
    public MainApplication service_running_server(boolean run) {
        _service_running_server = run;
        return this;
    }
    public boolean service_running_clip() {
        return _service_running_clip;
    }
    public MainApplication service_running_clip(boolean run) {
        _service_running_clip = run;
        return this;
    }

    private int _server_port = 0;
    public int server_port() {
        return _server_port;
    }
    public MainApplication server_port(int port) {
        _server_port = port;
        return this;
    }

    private String _root_key = null;
    public String root_key() {
        return _root_key;
    }
    public MainApplication root_key(String key) {
        _root_key = key;
        return this;
    }


    private SsadNative _si = null;
    public MainApplication set_ssad_native(SsadNative instance) {
        _si = instance;
        return this;
    }

    public void put_event(Json data) {
        if (_si != null) {
            _si.put_event(data);
        }
    }
}
