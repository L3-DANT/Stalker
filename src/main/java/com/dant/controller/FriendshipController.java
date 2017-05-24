package com.dant.controller;

import com.dant.business.FriendshipBusiness;
import com.dant.entity.dto.*;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import java.util.List;

/**
 * Created by 3502804 on 10/05/17.
 */
@Path("/api/friendship")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class FriendshipController {
    private FriendshipBusiness userBusiness = new FriendshipBusiness();

    @POST
    public FriendshipDTO askFriend(@FormParam("friendSource") String friendSource, @FormParam("friendDest") String friendDest) {
        return userBusiness.askFriend(friendSource, friendDest);
    }

    @POST
    @Path("/acceptFriend")
    public FriendshipDTO acceptFriend(@FormParam("friendSource") String friendSource, @FormParam("friendDest") String friendDest) {
        return userBusiness.acceptFriend(friendSource, friendDest);
    }

    @GET
    @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
    public List<UserDTO> getFriends(@PathParam("email") String email) {
        return userBusiness.getFriends(email);
    }

    @GET
    @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
    @Path("/getDemands")
    public List<UserDTO> getDemands(@PathParam("email") String email) {
        return userBusiness.getDemands(email);
    }

    @DELETE
    @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
    public void removeFriendship(@PathParam("friendSource") String friendSource, @PathParam("friendDest") String friendDest) {
        userBusiness.removeFriendship(friendSource, friendDest);
    }
}
