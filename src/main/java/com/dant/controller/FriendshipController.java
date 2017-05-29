package com.dant.controller;

import com.dant.business.FriendshipBusiness;
import com.dant.entity.Friendship;
import com.dant.entity.dto.*;
import org.omg.CORBA.FREE_MEM;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import java.util.ArrayList;
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
    public FriendshipDTO askFriend(@HeaderParam("Token") String token, Friendship friendship) {
        return userBusiness.askFriend(token, friendship);
    }

    @POST
    @Path("/acceptfriend")
    public FriendshipDTO acceptFriend(@HeaderParam("Token") String token, Friendship friendship) {
        return userBusiness.acceptFriend(token, friendship);
    }

    @GET
    public List<UserDTO> getFriendships(@HeaderParam("Token") String token) {
        return userBusiness.getFriendShips(token);
    }

    @GET
    @Path("/getFriends")
    public List<UserDTO> getFriends(@HeaderParam("Token") String token) {
        return userBusiness.getFriends(token);
    }

    @GET
    @Path("/getDemands")
    public List<UserDTO> getDemands(@HeaderParam("Token") String token) {
        return userBusiness.getDemands(token);
    }

    @DELETE
    public void removeFriendship(@HeaderParam("Token") String token, Friendship friendship) {
        userBusiness.removeFriendship(token, friendship);
    }
}
