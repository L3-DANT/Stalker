package com.dant.controller;

import com.dant.business.UserBusiness;
import com.dant.entity.dto.UserDTO;

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
    @Path("/{token}")
    public UserDTO getUser(@PathParam("token") String token) {
        return userBusiness.getUser(token).toDTO();
    }

    @DELETE
    @Path("/{token}")
    public void removeUser(@PathParam("token") String token) {
        userBusiness.removeUser(token);
    }

    @POST
    @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
    public UserDTO authenticate(@FormParam("email") String email, @FormParam("password") String password) {
        return userBusiness.authenticate(email, password).toDTO();
    }

    @POST
    @Path("/create")
    @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
    public UserDTO createUser(@FormParam("name") String name,
                           @FormParam("email") String email,
                           @FormParam("password") String password) {
        return userBusiness.createUser(name, email, password).toDTO();
    }

    @PUT
    @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
    public UserDTO updateUser(@FormParam("name") String name,
                              @FormParam("email") String email,
                              @FormParam("password") String password,
                              @FormParam("token") String token) {
        return userBusiness.updateUser(name, email, password, token).toDTO();
    }

}
