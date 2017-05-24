package com.dant.controller;

import com.dant.business.PositionBusiness;
import com.dant.entity.Position;
import com.dant.entity.dto.PositionDTO;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import java.util.List;

/**
 * Created by 3502804 on 19/05/17.
 */
@Path("/api/meetpoint")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class PositionController {
    private PositionBusiness positionBusiness = new PositionBusiness();

//    @POST
//    public UserDTO createPosition(@FormParam("token") String token,
//                                  @FormParam("latitude") double latitude,
//                                  @FormParam("longitude") double longitude,
//                                  @FormParam("time") long time) {
//        return positionBusiness.createPosition(token, latitude, longitude, time);
//    }

    @POST
    public PositionDTO createPosition(@FormParam("token") String token, Position position) {
        return positionBusiness.createPosition(token, position);
    }

    @GET
    public List<PositionDTO> getPositions(@HeaderParam("token") String token) {
        return positionBusiness.getPositions(token);
    }
}
