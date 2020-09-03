package com.laminariadesign.grin_plus_plus.tor.plugin;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodChannel;

public class TorPlugin implements FlutterPlugin {
    private MethodChannel methodChannel;
    private EventChannel serverRequestEventChannel;

    @Override
    public void onAttachedToEngine(FlutterPluginBinding binding) {
        methodChannel = new MethodChannel(
                binding.getBinaryMessenger(),
                TorPluginStrings.METHOD_CHANNEL_NAME
        );
        methodChannel.setMethodCallHandler(
                new TorMethodCallHandler(binding.getApplicationContext()));
        serverRequestEventChannel = new EventChannel(
                binding.getBinaryMessenger(),
                TorPluginStrings.TOR_SERVER_EVENT_CHANNEL_NAME
        );
        serverRequestEventChannel.setStreamHandler(new TorRequestEventChannel());
    }

    @Override
    public void onDetachedFromEngine(FlutterPluginBinding binding) {
        methodChannel.setMethodCallHandler(null);
        methodChannel = null;
        serverRequestEventChannel.setStreamHandler(null);
        serverRequestEventChannel = null;
    }
}
