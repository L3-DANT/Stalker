package com.dant.controller;

import com.dant.business.MeetPointBusiness;
import com.dant.entity.dto.MeetPointDTO;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import java.util.List;

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
    public MeetPointDTO createMeetPoint(@FormParam("user") String token,
                                        @FormParam("name") String name,
                                        @FormParam("address") String address,
                                        @FormParam("postalcode") int postalCode,
                                        @FormParam("town") String town,
                                        @FormParam("latitude") double latitude,
                                        @FormParam("longitude") double longitude) {
        return meetPointBusiness.createMeetPoint(token, name, address, postalCode, town, latitude, longitude);
    }

    @GET
    public List<MeetPointDTO> getMeetPoints(@FormParam("token") String token) {
        return meetPointBusiness.getMeetPoints(token);
    }

    @PUT
    @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
    public MeetPointDTO updateMeetPoint(@FormParam("id") String id,
                                        @FormParam("name") String name,
                                        @FormParam("address") String address,
                                        @FormParam("postalCode") int postalCode,
                                        @FormParam("town") String town,
                                        @FormParam("latitude") double latitude,
                                        @FormParam("town") double longitude) {
        return meetPointBusiness.updateMeetPoint(id, name, address, postalCode, town, latitude, longitude);
    }

    @DELETE
    public void removeMeetPoint(@HeaderParam("token") String id) {
        meetPointBusiness.removeMeetPoint(id);
    }
}
