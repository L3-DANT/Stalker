package com.dant.controller;

import com.dant.business.*;
import com.dant.dao.DAO;
import com.dant.entity.dto.*;
import com.dant.entity.*;

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
    public UserDTO authenticate(User u) {
        return userBusiness.authenticate(u);
    }

    @POST
    @Path("create")
    public UserDTO createUser(User user) {
        return userBusiness.createUser(user);
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

    @POST
    @Path("test")
    public String test(User u, @HeaderParam("Token") String token) {
        System.out.println("Token : " + token);
        System.out.println("User : " + u);
        return "bouh";
    }
}
