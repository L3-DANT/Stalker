package com.dant.util;
import com.dant.controller.WebSocketsController;
import com.pusher.client.Pusher;
import com.pusher.client.PusherOptions;
import com.pusher.client.channel.*;
import com.pusher.client.connection.ConnectionEventListener;
import com.pusher.client.connection.ConnectionState;
import com.pusher.client.connection.ConnectionStateChange;

public class PusherUtil {

    public static Pusher pusher() {
        return Init.pusher;
    }

    public boolean link(String channelName) {
        // Subscribe to a channel
        Pusher pusher = pusher();
        Channel channel = pusher.subscribe(channelName, new ChannelEventListener() {
            WebSocketsController controller = new WebSocketsController();

            @Override
            public void onSubscriptionSucceeded(String channelName) {
                System.out.println("Subscribed!");
            }

            @Override
            public void onEvent(String channelName, String eventName, String data) {
                System.out.println("Received event with data: " + data);
                controller.trigger(channelName, eventName, data);
            }
        }, "addPosition", "unsubscribe");
//        Channel channel = pusher.subscribe(channelName);
//        // Bind to listen for events called "my-event" sent to "my-channel"
//        channel.bind("addPosition", new SubscriptionEventListener() {
//            WebSocketsController controller = new WebSocketsController();
//
//            @Override
//            public void onEvent(String channel, String event, String data) {
//                System.out.println("Received event with data: " + data);
//                controller.trigger(channel, event, data);
//            }
//        });
        if (channel.isSubscribed())
            return true;
        else
            return false;
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

