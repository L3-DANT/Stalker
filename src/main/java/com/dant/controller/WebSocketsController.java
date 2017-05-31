package com.dant.controller;

import com.dant.util.PusherUtil;
import com.pusher.client.Pusher;
import com.pusher.client.channel.Channel;
import com.pusher.client.channel.SubscriptionEventListener;

/**
 * Created by Camilo on 31/05/2017.
 */
public class WebSocketsController {

    private Pusher pusher = PusherUtil.pusher();

    public boolean link(String channelName) {
        // Subscribe to a channel
        Channel channel = pusher.subscribe(channelName);

        // Bind to listen for events called "my-event" sent to "my-channel"
        channel.bind("position", new SubscriptionEventListener() {
            @Override
            public void onEvent(String channel, String event, String data) {
                System.out.println("Received event with data: " + data);
            }
        });
    }
}
