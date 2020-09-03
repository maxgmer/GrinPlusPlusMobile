package com.laminariadesign.grin_plus_plus.tor;

import android.content.Context;
import android.os.AsyncTask;

import org.torproject.android.binary.TorResourceInstaller;

import java.io.File;
import java.lang.ref.WeakReference;

public class TorInstaller extends AsyncTask<String, Integer, String> {
    private WeakReference<Context> context;
    private TorInstallationListener installationListener;
    private File torRootDir;
    private File torBin;
    private File torRc;

    public TorInstaller(Context context,  TorInstallationListener listener) {
        this.context = new WeakReference<>(context);
        installationListener = listener;
        torRootDir = new File(context.getFilesDir(), "tor_files");
    }

    public File getTorRootDir() {
        return torRootDir;
    }

    public File getTorBin() {
        return torBin;
    }

    public File getTorRc() {
        return torRc;
    }

    @Override
    protected String doInBackground(String... params) {
        try {
            if (torRootDir.mkdirs()) {
                TorResourceInstaller torResourceInstaller = new TorResourceInstaller(context.get(), torRootDir);
                torBin = torResourceInstaller.installResources();
                torRc = torResourceInstaller.getTorrcFile();
                boolean success = torBin != null && torBin.canExecute();
                if (success) {
                    return "Success";
                } else {
                    String error = "Tor files couldn't be created";
                    return "Failure: " + error;
                }
            } else {
                String error = "Tor directory couldn't be created";
                return "Failure: " + error;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "Failure: " + e.getMessage();
        }
    }

    @Override
    protected void onPostExecute(String result) {
        super.onPostExecute(result);
        if ("Success".equals(result)) {
            installationListener.torInstalled(true, null);
        } else {
            String error = result.replaceFirst("Failure: ", "");
            installationListener.torInstalled(false, error);
        }
    }

    interface TorInstallationListener {
        void torInstalled(boolean success, String error);
    }
}

