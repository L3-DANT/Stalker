package com.dant.controller;

import com.dant.business.FriendshipBusiness;
import com.dant.entity.dto.*;

import javax.ws.rs.*;
import java.util.List;

/**
 * Created by 3502804 on 10/05/17.
 */
public class FriendshipController {
    private FriendshipBusiness userBusiness = new FriendshipBusiness();

    @POST
    @Path("/askFriend")
    public FriendshipDTO askFriend(@FormParam("friendSource") String friendSource, @FormParam("friendDest") String friendDest) {
        return userBusiness.askFriend(friendSource, friendDest);
    }

    @POST
    @Path("/acceptFriend")
    public FriendshipDTO acceptFriend(@FormParam("friendSource") String friendSource, @FormParam("friendDest") String friendDest) {
        return userBusiness.acceptFriend(friendSource, friendDest);
    }

    @GET
    @Path("/getFriends")
    public List<UserDTO> getFriends(@FormParam("email") String email) {
        return userBusiness.getFriends(email);
    }

    @GET
    @Path("/getDemands")
    public List<UserDTO> getDemands(@FormParam("email") String email) {
        return userBusiness.getDemands(email);
    }

    @DELETE
    public void removeFriendship(@FormParam("friendSource") String friendSource, @FormParam("friendDest") String friendDest) {
        userBusiness.removeFriendship(friendSource, friendDest);
    }
}
