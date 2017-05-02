package com.dant.controller;

import com.dant.business.UserBusiness;
import com.dant.entity.User;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import java.util.List;

/**
 * Created by pitton on 2017-02-20.
 */
@Path("/api/account")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class UserController {

    private UserBusiness userBusiness = new UserBusiness();

    @GET
    @Path("/create")
    public User create(@QueryParam("email") String email, @QueryParam("name") String name) {
        return userBusiness.create(email, name);
    }

    @GET
    @Path("/getUser")
    public User getUser(@QueryParam("email") String email) {
        return userBusiness.getAccount(email);
    }

    @GET
    @Path("/getFriends")
    public List<User> getFriends(@QueryParam("email") String email) {
        return userBusiness.getFriends(email);
    }

}
