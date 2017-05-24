package com.dant.controller;

import com.dant.business.UserBusiness;
import com.dant.entity.User;
import com.dant.entity.dto.*;
import com.mongodb.util.JSON;

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

    @GET
    @Path("/authenticate")
    public UserDTO authenticate(User u) {
        return userBusiness.authenticate(u);
    }

    @POST
    public UserDTO createUser(User user) {
        return userBusiness.createUser(user);
    }

    @PUT
    public UserDTO updateUser(User user) {
        return userBusiness.updateUser(user);
    }

    @DELETE
    @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
    public void removeUser(@PathParam("email") String email) {
        userBusiness.removeUser(email);
    }
}
