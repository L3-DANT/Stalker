package com.dant.controller;

import com.dant.business.*;
import com.dant.entity.dto.*;
import com.dant.entity.*;
import com.dant.util.PusherUtil;
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
    private Pusher pusher = PusherUtil.pusher();

    @POST
    public UserDTO createUser(User user) {
        return userBusiness.createUser(user);
    }

    @POST
    @Path("me")
    public UserDTO authenticate(User u) {
//        PusherUtil pu = new PusherUtil();
//        pu.link(u.getToken());
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
