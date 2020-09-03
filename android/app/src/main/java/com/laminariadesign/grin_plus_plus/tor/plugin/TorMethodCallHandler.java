package com.laminariadesign.grin_plus_plus.tor.plugin;

import android.content.Context;

import androidx.annotation.NonNull;

import com.laminariadesign.grin_plus_plus.tor.Tor;

import java.io.IOException;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class TorMethodCallHandler implements MethodChannel.MethodCallHandler {
    private final Context context;
    private Tor tor;

    public TorMethodCallHandler(Context context) {
        this.context = context;
    }

    @Override
    public void onMethodCall(MethodCall call, @NonNull MethodChannel.Result result) {
        String methodName = call.method;
        if (methodName.equals(TorPluginStrings.METHOD_START_TOR_SERVICE)) {
            this.tor = new Tor();
            int controlPort = call.argument(TorPluginStrings.START_TOR_SERVICE_ARG1);
            int socksPort = call.argument(TorPluginStrings.START_TOR_SERVICE_ARG2);
            String controlPassword = call.argument(TorPluginStrings.START_TOR_SERVICE_ARG3);
            String hashedControlPassword = call.argument(TorPluginStrings.START_TOR_SERVICE_ARG4);
            tor.startHiddenService(context, (success, message) -> {
                if (success) {
                    result.success(message);
                } else {
                    result.error("TOR", message, null);
                }
            }, controlPort, socksPort, controlPassword, hashedControlPassword);
        } else if (methodName.equals(TorPluginStrings.METHOD_STOP_TOR_SERVICE)) {
            if (tor != null) {
                tor.stopHiddenService();
            }
        } else {
            result.notImplemented();
        }
    }
}
