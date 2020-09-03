package com.laminariadesign.grin_plus_plus.tor;

import com.jrummyapps.android.shell.CommandResult;

public class ShellHelper {
    public static int exec(String cmd) throws Exception {
        CommandResult shellResult = com.jrummyapps.android.shell.Shell.run(cmd);

        if (!shellResult.isSuccessful()) {
            throw new Exception("Error: " + shellResult.exitCode + " ERR=" + shellResult.getStderr() + " OUT=" + shellResult.getStdout());
        }

        return shellResult.exitCode;
    }
}
