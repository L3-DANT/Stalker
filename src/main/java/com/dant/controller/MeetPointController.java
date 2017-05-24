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
    public MeetPointDTO createMeetPoint(MeetPoint meetPoint) {
        return meetPointBusiness.createMeetPoint(meetPoint);
    }

    @PUT
    public MeetPointDTO updateMeetPoint(MeetPoint meetPoint) {
        return meetPointBusiness.updateMeetPoint(meetPoint);
    }

    @GET
    public List<MeetPointDTO> getMeetPoints(@PathParam("email") String emailUser) {
        return meetPointBusiness.getMeetPoints(emailUser);
    }

    @DELETE
    @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
    public void removeMeetPoint(@PathParam("id") String id) {
        meetPointBusiness.removeMeetPoint(id);
    }
}
