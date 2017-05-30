package com.dant.controller;

import com.dant.business.FriendshipBusiness;
import com.dant.entity.Friendship;
import com.dant.entity.dto.*;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import java.util.List;

/**
 * Created by 3502804 on 10/05/17.
 */
@Path("/api/friend")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class FriendshipController {
    private FriendshipBusiness friendshipBusiness = new FriendshipBusiness();

    @POST
    public FriendshipDTO askFriend(@HeaderParam("Token") String token, Friendship friendship) {
        return friendshipBusiness.askFriend(token, friendship);
    }

    @PUT
    public FriendshipDTO acceptFriend(@HeaderParam("Token") String token, Friendship friendship) {
        return friendshipBusiness.acceptFriend(token, friendship);
    }

    @GET
    @Consumes()
    public List<UserDTO> getFriendships(@HeaderParam("Token") String token) {
        return friendshipBusiness.getFriendShips(token);
    }

    @GET
    @Path("/getfriends")
    public List<UserDTO> getFriends(@HeaderParam("Token") String token) {
        return friendshipBusiness.getFriends(token);
    }

    @GET
    @Path("/getdemands")
    public List<UserDTO> getDemands(@HeaderParam("Token") String token) {
        return friendshipBusiness.getDemands(token);
    }

    @DELETE
    public void removeFriendship(@HeaderParam("Token") String token, Friendship friendship) {
        friendshipBusiness.removeFriendship(token, friendship);
    }
}
