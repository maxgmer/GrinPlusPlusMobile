package com.laminariadesign.grin_plus_plus.tor;

import android.content.Context;

public class Tor {
    private static final String TAG = "TOR";
    private TorManager torManager;

    public void startHiddenService(Context context, TorManager.HiddenServiceStarted startListener,
                                   int controlPort, int socksPort, String controlPassword,
                                   String hashedControlPassword) {
        torManager = new TorManager();
        torManager.startHiddenService(context, startListener,
                controlPort, socksPort, controlPassword, hashedControlPassword);
    }

    /**
     * Stops tor hidden service.
     */
    public void stopHiddenService() {
        if (torManager != null) {
            torManager.stopTor();
            torManager = null;
        }
    }
}
