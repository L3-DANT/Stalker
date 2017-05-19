package com.dant.controller;

import com.dant.business.UserBusiness;
import com.dant.entity.dto.*;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import java.util.List;

/**
 * Created by pitton on 2017-02-20.
 */
@Path("/api/user")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class UserController {
    private UserBusiness userBusiness = new UserBusiness();

    @POST
    @Path("/authenticate")
    @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
    public UserDTO authenticate(@FormParam("email") String email,
                                @FormParam("password") String password) {
        return userBusiness.authenticate(email, password);
    }

    @POST
    @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
    public UserDTO createUser(@FormParam("name") String name,
                              @FormParam("email") String email,
                              @FormParam("password") String password) {
        return userBusiness.createUser(name, email, password);
    }

    @PUT
    @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
    public UserDTO updateUser(@FormParam("name") String name,
                              @FormParam("email") String email,
                              @FormParam("password") String password,
                              @FormParam("token") String token) {
        return userBusiness.updateUser(name, email, password, token);
    }

    @DELETE
    public void removeUser(@HeaderParam("token") String token) {
        userBusiness.removeUser(token);
    }

//    @GET
//    @Path("/friends")
//    public List<UserDTO> getFriends(@FormParam("token") String token) {
//        return userBusiness.getFriends(token);
//    }
}
