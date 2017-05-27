package com.dant.controller;

import com.dant.business.MeetPointBusiness;
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
    @Path("/test/all")
    public List<MeetPointDTO> getMeetPointsTest(@HeaderParam("Token") String token) {
        List<MeetPointDTO> meetpoints = new ArrayList<>();
        meetpoints.add(new MeetPointDTO("0", "Tour Eiffel", "Champ de Mars, 5 Avenue Anatole", 75007, "Paris", 48.8584, 2.2945));
        meetpoints.add(new MeetPointDTO("1", "Cathédrale Notre-Dame de Paris", "6 Parvis Notre-Dame - Pl. Jean-Paul II", 75004, "Paris", 48.8530, 2.3499));
        meetpoints.add(new MeetPointDTO("2", "Arc de Triomphe", "Place Charles de Gaulle", 75008, "Paris", 48.8738, 2.2950));
        return meetpoints;
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
