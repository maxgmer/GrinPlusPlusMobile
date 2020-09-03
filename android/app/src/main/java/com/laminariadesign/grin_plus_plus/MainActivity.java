package com.laminariadesign.grin_plus_plus;

import android.os.Bundle;
import android.os.StrictMode;

import androidx.annotation.NonNull;

import com.laminariadesign.grin_plus_plus.tor.plugin.TorPlugin;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        // This is required so that tor library can use blocking code
        // to check, if the service is running (it blocks for a very short time,
        // basically to create socket to connect to localhost, which is instant).
        // All blocking operations you create still must be in a separate thread.
        StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
        StrictMode.setThreadPolicy(policy);
    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        flutterEngine.getPlugins().add(new TorPlugin());
    }
}