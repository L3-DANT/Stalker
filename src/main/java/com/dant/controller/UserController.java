package com.dant.controller;

import com.dant.business.UserBusiness;
import com.dant.entity.User;
import com.dant.entity.dto.UserDTO;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import java.util.logging.Logger;

/**
 * Created by pitton on 2017-02-20.
 */
@Path("/api/user")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class UserController {

    private UserBusiness userBusiness = new UserBusiness();
    private static final Logger log = Logger.getLogger(UserController.class.getName());

    @POST
    @Path("/authenticate")
    public UserDTO authenticate(User u) {
        log.info("request received \ncreate: " +
                u + " " +
                userBusiness.authenticate(u.getEmail(), u.getPassword()));
        return userBusiness.authenticate(u.getEmail(), u.getPassword());
    }

    @POST
    public UserDTO createUser(User u) {
        return userBusiness.createUser(u.getName(), u.getEmail(), u.getPassword());
    }

    @PUT
    public UserDTO updateUser(String name,
                              String email,
                              String password,
                              String token) {
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
