package com.dant.websocket;

import com.pusher.client.Pusher;
import com.pusher.client.PusherOptions;
import com.pusher.client.channel.*;
import com.pusher.client.connection.*;
import com.pusher.client.util.HttpAuthorizer;

/**
 * Created by 3502804 on 30/05/17.
 */
public class ComSocket {
    public static String YOUR_APP_KEY = "ff19fcd2fd235bddc039";

    public static void connect() {
//        HttpAuthorizer authorizer = new HttpAuthorizer("http://example.com/some_auth_endpoint");
//        PusherOptions options = new PusherOptions().setAuthorizer(authorizer);
//        options.setCluster("eu");
//        Pusher pusher = new Pusher(YOUR_APP_KEY, options);
        Pusher pusher = new Pusher(YOUR_APP_KEY);
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

        Channel channel = pusher.subscribe("my-channel");

        // Bind to listen for events called "my-event" sent to "my-channel"
        channel.bind("my-event", new SubscriptionEventListener() {
            @Override
            public void onEvent(String channel, String event, String data) {
                System.out.println("Received event with data: " + data);
            }
        });

        // Disconnect from the service (or become disconnected my network conditions)
        pusher.disconnect();

        // Reconnect, with all channel subscriptions and event bindings automatically recreated
        pusher.connect();
    }


}
