package com.dant.controller;

import com.dant.business.AccountBusiness;
import com.dant.entity.Account;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;

/**
 * Created by pitton on 2017-02-20.
 */
@Path("/api/account")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class AccountController {

    private AccountBusiness accountBusiness = new AccountBusiness();

    @GET
    @Path("/create")
    public Account create(@QueryParam("email") String email) {
        return accountBusiness.create(email);
    }


    @GET
    public Account getAccount(@QueryParam("email") String email) {
        return accountBusiness.getAccount(email);
    }
}
