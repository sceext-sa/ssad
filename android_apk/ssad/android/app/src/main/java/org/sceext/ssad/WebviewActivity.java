package org.sceext.ssad;

import android.os.Bundle;
import android.graphics.Color;

import com.facebook.react.ReactActivity;

public class WebviewActivity extends ReactActivity {

    @Override
    protected String getMainComponentName() {
        return "ssad_webview";
    }

    @Override
    public void onCreate(Bundle saved) {
        super.onCreate(saved);
        // set window background-color
        getWindow().setStatusBarColor(Color.BLACK);
    }
}
