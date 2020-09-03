package com.laminariadesign.grin_plus_plus.tor;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import fi.iki.elonen.NanoHTTPD;

public class Server extends NanoHTTPD {
    private static List<RequestListener> requestListeners = new ArrayList<>();

    public Server(int port, int timeout) throws IOException {
        super(port);
        start(timeout, false);
    }

    @Override
    public Response serve(IHTTPSession session) {
        if (session.getMethod() == Method.POST) {
            try {
                HashMap<String, String> bodyMap = new HashMap<>();
                session.parseBody(bodyMap);

                String rawPostBody = bodyMap.get("postData");
                if (rawPostBody != null) {
                    notifyRequestListeners(new ServerResponseBody(true, rawPostBody));
                }
                return newFixedLengthResponse("OK");
            } catch (IOException | ResponseException e) {
                e.printStackTrace();
                notifyRequestListeners(new ServerResponseBody(false, e.getMessage()));
            }
        }
        return newFixedLengthResponse("OK");
    }

    public static void addRequestListener(RequestListener requestListener) {
        requestListeners.add(requestListener);
    }

    public static void removeRequestListener(RequestListener requestListener) {
        requestListeners.remove(requestListener);
    }

    private void notifyRequestListeners(ServerResponseBody body) {
        for (RequestListener requestListener : requestListeners) {
            requestListener.onRequestBody(body);
        }
    }

    public interface RequestListener {
        void onRequestBody(ServerResponseBody body);
    }
    public static class ServerResponseBody {
        public final boolean isSuccess;
        public final String body;

        private ServerResponseBody(boolean isSuccess, String body) {
            this.isSuccess = isSuccess;
            this.body = body;
        }
    }
}
