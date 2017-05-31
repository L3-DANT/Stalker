package com.dant.controller;

import com.dant.business.FriendshipBusiness;
import com.dant.business.PositionBusiness;
import com.dant.entity.Position;
import com.dant.entity.User;
import com.dant.util.PusherUtil;
import com.pusher.rest.Pusher;
import com.google.gson.*;
import javax.ws.rs.Consumes;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import java.util.Collections;


/**
 * Created by Camilo on 31/05/2017.
 */
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class WebSocketsController {

    private Pusher pusherWriter = new Pusher("346005", "ff19fcd2fd235bddc039", "cc12ac268781ad64538f");
    private com.pusher.client.Pusher pusherReader = PusherUtil.pusher();
    Gson gson = new Gson();

    private FriendshipBusiness friendshipBusiness = new FriendshipBusiness();
    private PositionBusiness positionBusinness = new PositionBusiness();

    public void trigger(String channel, String event, String data) {
        pusherWriter.setCluster("eu");
        pusherWriter.setEncrypted(true);
        switch(event) {
            case "addPosition":
                Position p = gson.fromJson(data, Position.class);
                positionBusinness.createWBPosition(p);
                pusherWriter.trigger(channel, event, gson.toJson(friendshipBusiness.getFriends(channel)));
                break;
            case "unsubscribe":
                pusherReader.unsubscribe(channel);
                break;
        }
    }

}
