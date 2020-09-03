package com.laminariadesign.grin_plus_plus.tor;

import android.content.Context;

import net.freehaven.tor.control.PasswordDigest;
import net.freehaven.tor.control.TorControlConnection;

import java.io.IOException;
import java.net.Socket;

public class TorManager {
    private TorInstaller torInstaller;
    private TorLauncher torLauncher;
    private TorControlConnection torControlConnection;
    private Server server;

    public TorManager() {}

    public void startHiddenService(Context context, HiddenServiceStarted startListener,
                                   int controlPort, int socksPort,
                                   String controlPassword, String hashedControlPassword) {
        this.torInstaller = new TorInstaller(context, (installSuccess, installError) -> {
            if (installSuccess) {
                runTor(startListener, controlPort, socksPort, controlPassword, hashedControlPassword);
            } else {
                startListener.serviceStarted(false, installError);
            }
        });
        torInstaller.execute();
    }


    public void stopTor() {
        if (hiddenServiceManager != null) {
            try {
                hiddenServiceManager.stop();
                server.stop();
                hiddenServiceManager = null;
                server = null;
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    private void runTor(HiddenServiceStarted startListener, int controlPort, int socksPort,
                        String controlPassword, String hashedControlPassword) {
        TorLauncher.TorStarted onTorStartup = (startSuccess, startError) -> {
            if (startSuccess) {
                openControlConnection(startListener, controlPort, controlPassword);
                runHiddenService(startListener);
            } else {
                startListener.serviceStarted(false, startError);
            }
        };
        torLauncher = new TorLauncher(
                torInstaller, onTorStartup,
                controlPort, socksPort,
                controlPassword, hashedControlPassword);
        torLauncher.execute();
    }

    private void openControlConnection(HiddenServiceStarted startListener,
                                       int controlPort, String controlPassword) {
        try {
            Socket socket = new Socket("127.0.0.1", controlPort);
            torControlConnection = new TorControlConnection(socket);
            torControlConnection.launchThread(true);
            torControlConnection.authenticate(controlPassword.getBytes());
        } catch (IOException e) {
            e.printStackTrace();
            startListener.serviceStarted(false, "Couldn't open tor control connection");
        }
    }

    private void runHiddenService(HiddenServiceStarted startListener) {
        torControlConnection.addOnion();
    }

    public interface HiddenServiceStarted {
        /**
         * Start service callback.
         * @param success
         * If service started successfully.
         * @param message
         * If success is true the message will contain tor address (without .onion).
         * If success is false the message will contain error message.
         */
        void serviceStarted(boolean success, String message);
    }
}
