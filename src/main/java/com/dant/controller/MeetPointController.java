package com.dant.controller;

import com.dant.business.MeetPointBusiness;
import com.dant.entity.MeetPoint;
import com.dant.entity.dto.MeetPointDTO;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import java.util.ArrayList;
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

    @GET
    @Path("/test/all")
    public List<MeetPointDTO> getMeetPointsTest(@HeaderParam("Token") String token) {
        List<MeetPointDTO> meetpoints = new ArrayList<>();
        meetpoints.add(new MeetPointDTO("0", "Tour Eiffel", "Champ de Mars, 5 Avenue Anatole", 75007, "Paris", 48.8584, 2.2945));
        meetpoints.add(new MeetPointDTO("1", "Cathédrale Notre-Dame de Paris", "6 Parvis Notre-Dame - Pl. Jean-Paul II", 75004, "Paris", 48.8530, 2.3499));
        meetpoints.add(new MeetPointDTO("2", "Arc de Triomphe", "Place Charles de Gaulle", 75008, "Paris", 48.8738, 2.2950));
        return meetpoints;
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
