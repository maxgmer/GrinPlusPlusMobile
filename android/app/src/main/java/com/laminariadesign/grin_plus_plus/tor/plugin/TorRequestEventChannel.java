package com.laminariadesign.grin_plus_plus.tor.plugin;

import com.laminariadesign.grin_plus_plus.tor.Server;

import io.flutter.plugin.common.EventChannel;

public class TorRequestEventChannel implements EventChannel.StreamHandler {
    private Server.RequestListener requestListener;

    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {
        requestListener = request -> {
            if (request.isSuccess) {
                events.success(request.body);
            }
        };
        Server.addRequestListener(requestListener);
    }

    @Override
    public void onCancel(Object arguments) {
        Server.removeRequestListener(this.requestListener);
    }
}
