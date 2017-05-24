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

//    @POST
//    @Path("/authenticate")
//    public UserDTO authenticate(@FormParam("email") String email,
//                                @FormParam("password") String password) {
//        return userBusiness.authenticate(email, password);
//    }

    @GET
    @Path("/authenticate")
    public UserDTO authenticate(User u) {
        return userBusiness.authenticate(u);
    }

//    @POST
//    public UserDTO createUser(@PathParam("name") String name,
//                              @FormParam("email") String email,
//                              @FormParam("password") String password) {
//        return userBusiness.createUser(name, email, password);
//    }
    @POST
    public UserDTO createUser(User user) {
        return userBusiness.createUser(user);
    }

    @PUT
    public UserDTO updateUser(@FormParam("name") String name,
                              @FormParam("email") String email,
                              @FormParam("password") String password,
                              @FormParam("token") String token) {
        return userBusiness.updateUser(name, email, password, token);
    }

    @DELETE
    @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
    public void removeUser(@HeaderParam("token") String token) {
        userBusiness.removeUser(token);
    }
}
