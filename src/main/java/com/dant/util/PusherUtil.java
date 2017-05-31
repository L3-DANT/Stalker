package com.dant.util;
import com.pusher.client.Pusher;
import com.pusher.client.PusherOptions;
import com.pusher.client.connection.ConnectionEventListener;
import com.pusher.client.connection.ConnectionState;
import com.pusher.client.connection.ConnectionStateChange;

public class PusherUtil {

    public static Pusher pusher() {
        return Init.pusher;
    }

    private static final class Init {

        private static final Pusher pusher = getPusher();

        private static Pusher getPusher() {
            PusherOptions options = new PusherOptions();
            options.setCluster("eu");
            Pusher pusher = new Pusher("ff19fcd2fd235bddc039", options);
            pusher.connect(new ConnectionEventListener() {
                @Override
                public void onConnectionStateChange(ConnectionStateChange change) {
                    System.out.println("State changed to " + change.getCurrentState() +
                            " from " + change.getPreviousState());
                }

                @Override
                public void onError(String message, String code, Exception e) {
                    System.out.println("There was a problem connecting!");
                }
            }, ConnectionState.ALL);
            return pusher;
        }

    }
}

