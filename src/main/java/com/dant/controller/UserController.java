package com.dant.controller;

import com.dant.app.LogFilter;
import com.dant.business.UserBusiness;
import com.dant.entity.User;
import com.dant.entity.dto.MeetPointDTO;
import com.dant.entity.dto.UserDTO;

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
    private LogFilter log = new LogFilter();

    @POST
    @Path("/authenticate")
    public UserDTO authenticate(User u) {
        return userBusiness.authenticate(u.getEmail(), u.getPassword());
    }

    @GET
    @Path("/friends")
    public List<UserDTO> getFriends(@HeaderParam("token") String token) {
        return userBusiness.getFriends(token);
    }

    @GET
    @Path("/meetpoints")
    public List<MeetPointDTO> getMeetPoints(@HeaderParam("token") String token) {
        return userBusiness.getMeetPoints(token);
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

}
