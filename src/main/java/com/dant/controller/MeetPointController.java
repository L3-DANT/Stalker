package com.dant.controller;

import com.dant.business.MeetPointBusiness;
import com.dant.entity.MeetPoint;
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
    public MeetPointDTO createMeetPoint(@HeaderParam("Token") String token, MeetPoint meetPoint) {
        return meetPointBusiness.createMeetPoint(token, meetPoint);
    }

    @PUT
    public MeetPointDTO updateMeetPoint(@HeaderParam("Token") String token, MeetPoint meetPoint) {
        return meetPointBusiness.updateMeetPoint(token, meetPoint);
    }

    @GET
//    @Path("/{email}")
    public List<MeetPointDTO> getMeetPoints(@HeaderParam("Token") String token) {
        return meetPointBusiness.getMeetPoints(token);
    }

    @DELETE
    @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
    public void removeMeetPoint(@HeaderParam("Token") String token, @PathParam("id") String id) {
        meetPointBusiness.removeMeetPoint(token, id);
    }
}
