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

    @POST
    public PositionDTO createPosition(Position position) {
        return positionBusiness.createPosition(position);
    }

    @GET
    public List<PositionDTO> getPositions(@PathParam("email") String emailUser) {
        return positionBusiness.getPositions(emailUser);
    }
}
