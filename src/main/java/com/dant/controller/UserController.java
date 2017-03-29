package com.dant.controller;

import com.dant.business.UserBusiness;
import com.dant.entity.User;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;

/**
 * Created by pitton on 2017-02-20.
 */
@Path("/api/account")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class UserController {

    private UserBusiness accountBusiness = new UserBusiness();

    @GET
    @Path("/create")
    public User create(@QueryParam("email") String email) {
        return accountBusiness.create(email);
    }


    @GET
    public User getAccount(@QueryParam("email") String email) {
        return accountBusiness.getAccount(email);
    }
}
