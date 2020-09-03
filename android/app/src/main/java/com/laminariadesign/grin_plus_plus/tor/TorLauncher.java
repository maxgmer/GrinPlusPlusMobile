package com.laminariadesign.grin_plus_plus.tor;

import android.os.AsyncTask;
import android.util.Log;

import java.io.File;

public class TorLauncher extends AsyncTask<String, Integer, String> {
    private static final String TAG = "TorServiceLauncher";
    private TorInstaller torInstaller;
    private TorStarted torStarted;
    private int controlPort;
    private int socksPort;
    private String controlPassword;
    private String hashedControlPassword;

    public TorLauncher(TorInstaller installer, TorStarted listener,
                       int controlPort, int socksPort, String controlPassword,
                       String hashedControlPassword) {
        this.controlPort = controlPort;
        this.socksPort = socksPort;
        this.controlPassword = controlPassword;
        this.hashedControlPassword = hashedControlPassword;
        torStarted = listener;
        torInstaller = installer;
    }

    @Override
    protected String doInBackground(String... params) {
        try {
            File serviceDataDir = new File(torInstaller.getTorRootDir(), "data");
            File torRc = torInstaller.getTorRc();
            File torBin = torInstaller.getTorBin();

            if (!torRc.exists()) {
                String error = "Torrc is not installed: " + torRc.getCanonicalPath();
                Log.e(TAG, error);
                return "Failure: " + error;
            }

            String torCmdString = torBin.getCanonicalPath()
                    + " --ControlPort " + controlPort
                    + " --SocksPort " + socksPort
                    + " --DataDirectory " + serviceDataDir.getCanonicalPath()
                    + " --HashedControlPassword " + hashedControlPassword
                    + " --defaults-torrc " + torRc
                    + " --ignore-missing-torrc";

            try {
                ShellHelper.exec(torCmdString + " --verify-config");
            } catch (Exception e) {
                String error = "Could not verify tor configuration: " + e.getMessage();
                Log.e(TAG, error);
                return "Failure: " + error;
            }

            int exitCode = -1;
            try {
                exitCode = ShellHelper.exec(torCmdString);
            } catch (Exception e) {
                String error = "Tor was unable to start: " + e.getMessage();
                Log.e(TAG, error);
                return "Failure: " + error;
            }

            if (exitCode != 0) {
                String error = "Tor did not start. Exit:" + exitCode;
                Log.e(TAG, error);
                return "Failure: " + error;
            }

            return "Success";
        } catch (Exception e) {
            String error = "Tor file path couldn't be obtained: " + e.getMessage();
            Log.e(TAG, error);
            return "Failure: " + error;
        }
    }

    @Override
    protected void onPostExecute(String result) {
        super.onPostExecute(result);
        if ("Success".equals(result)) {
            torStarted.onTorStarted(true, null);
        } else {
            String error = result.replaceFirst("Failure: ", "");
            torStarted.onTorStarted(false, error);
        }
    }

    public interface TorStarted {
        void onTorStarted(boolean success, String error);
    }
}

