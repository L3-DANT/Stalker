package com.dant.controller;

import com.dant.business.MeetPointBusiness;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;

/**
 * Created by 3604290 on 03/05/17.
 */
@Path("/api/meetpoint")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class MeetPointController {

    private MeetPointBusiness meetPointBusiness = new MeetPointBusiness();

    @POST
    @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
    public void createMeetPoint(@FormParam("user") String token,
                                @FormParam("name") String name,
                                @FormParam("address") String address,
                                @FormParam("postalcode") int postalCode,
                                @FormParam("town") String town,
                                @FormParam("latitude") double latitude,
                                @FormParam("longitude") double longitude) {
        meetPointBusiness.createMeetPoint(token, name, address, postalCode, town, latitude, longitude);
    }

}
