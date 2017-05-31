package com.dant.controller;

import com.dant.business.*;
import com.dant.entity.dto.*;
import com.dant.entity.*;
import com.pusher.client.PusherOptions;
import com.pusher.client.channel.Channel;
import com.pusher.client.Pusher;
import com.pusher.client.channel.SubscriptionEventListener;
import com.pusher.client.connection.ConnectionEventListener;
import com.pusher.client.connection.ConnectionState;
import com.pusher.client.connection.ConnectionStateChange;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;

/**
 * Created by pitton on 2017-02-20.
 */
@Path("/api/user")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class UserController {

    private UserBusiness userBusiness = new UserBusiness();

    @POST
    public UserDTO createUser(User user) {
        return userBusiness.createUser(user);
    }

    @POST
    @Path("me")
    public UserDTO authenticate(User u) {
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

    // Subscribe to a channel
        Channel channel = pusher.subscribe("my-channel");

    // Bind to listen for events called "my-event" sent to "my-channel"
        channel.bind("my-event", new SubscriptionEventListener() {
            @Override
            public void onEvent(String channel, String event, String data) {
                System.out.println("Received event with data: " + data);
            }
        });
        return userBusiness.authenticate(u);
    }

    @PUT
    public UserDTO updateUser(User user) {
        return userBusiness.updateUser(user);
    }

    @DELETE
    @Consumes()
    public void removeUser(@HeaderParam("Token") String token) {
        userBusiness.removeUser(token);
    }
}
