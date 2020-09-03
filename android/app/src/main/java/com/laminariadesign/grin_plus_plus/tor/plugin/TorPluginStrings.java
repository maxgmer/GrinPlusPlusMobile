package com.laminariadesign.grin_plus_plus.tor.plugin;

public class TorPluginStrings {
    public static final String METHOD_CHANNEL_NAME = "com.laminariadesign.grin_plus_plus/tor_methods";
    public static final String TOR_SERVER_EVENT_CHANNEL_NAME = "com.laminariadesign.grin_plus_plus/tor_server_event";

    public static final String METHOD_START_TOR_SERVICE = "startTorService";
    public static final String START_TOR_SERVICE_ARG1 = "controlPort";
    public static final String START_TOR_SERVICE_ARG2 = "socksPort";
    public static final String START_TOR_SERVICE_ARG3 = "controlPassword";
    public static final String START_TOR_SERVICE_ARG4 = "hashedControlPassword";

    public static final String METHOD_STOP_TOR_SERVICE = "stopTorService";
}
