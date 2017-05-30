package com.dant.business;

import com.dant.dao.DAO;
import com.dant.entity.*;
import com.dant.entity.dto.MeetPointDTO;

import javax.ws.rs.BadRequestException;
import javax.ws.rs.ForbiddenException;
import javax.ws.rs.NotFoundException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by 3604290 on 03/05/17.
 */
public class MeetPointBusiness {

    private final DAO<MeetPoint> meetPointDAO = new DAO<>();

    public MeetPointDTO createMeetPoint(String token, MeetPoint meetPoint) {
        User user = UtilBusiness.checkToken(token);
        if(!user.getEmail().equals(meetPoint.getEmailUser()))
            throw new ForbiddenException();
        if(meetPointDAO.getOne(MeetPoint.class, "id", meetPoint.getOurId()) != null) {
            throw new BadRequestException();
        }
        return meetPointDAO.save(meetPoint).toDTO();
    }

    public MeetPointDTO updateMeetPoint(String token, MeetPoint m) {
        User user = UtilBusiness.checkToken(token);
        MeetPoint meetPoint = meetPointDAO.getOne(MeetPoint.class, "id", m.getOurId());
        if(meetPoint == null)
            throw new NotFoundException();
        if(!user.getEmail().equals(meetPoint.getEmailUser()))
            throw new ForbiddenException();
        meetPoint.setName(m.getName());
        meetPoint.setAdress(m.getAdress());
        meetPoint.setZipCode(m.getZipCode());
        meetPoint.setTown(m.getTown());
        meetPoint.setLatitude(m.getLatitude());
        meetPoint.setLongitude(m.getLongitude());
        meetPoint.setEmailUser(m.getEmailUser());
        return meetPointDAO.save(meetPoint).toDTO();
    }

    public List<MeetPointDTO> getMeetPoints(String token) {
        User user = UtilBusiness.checkToken(token);
        List<MeetPointDTO> meetPoints = new ArrayList<>();
        for(MeetPoint meetPoint : meetPointDAO.getAll(MeetPoint.class, "emailUser", user.getEmail())) {
            meetPoints.add(meetPoint.toDTO());
        }
        return meetPoints;
    }

    public void removeMeetPoint(String token, String id) {
        User user = UtilBusiness.checkToken(token);
        MeetPoint meetPoint = meetPointDAO.getOne(MeetPoint.class, "id", id);
        if(meetPoint == null)
            throw new NotFoundException();
        if(!user.getEmail().equals(meetPoint.getEmailUser()))
            throw new ForbiddenException();
        meetPointDAO.delete(MeetPoint.class, "id", id);
    }
}
