package org.sceext.ssad;

import java.util.Arrays;
import java.util.List;

import android.app.Application;

import com.facebook.react.ReactApplication;
import com.facebook.react.ReactNativeHost;
import com.facebook.react.ReactPackage;
import com.facebook.react.shell.MainReactPackage;
import com.facebook.soloader.SoLoader;

import org.sceext.ssad.ssad_native.Config;


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
        // init
        _init();
    }


    // custom code
    private static MainApplication _instance = null;
    private static Config _c;

    private void _init() {
        _instance = this;  // save instance
        // create single instance
        _c = new Config();
    }

    public static MainApplication instance() {
        return _instance;
    }

    public static Config config() {
        return _c;
    }
}
