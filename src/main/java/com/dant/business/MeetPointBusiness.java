package com.dant.business;

import com.dant.dao.DAO;
import com.dant.entity.*;
import com.dant.entity.dto.MeetPointDTO;

import javax.ws.rs.BadRequestException;
import javax.ws.rs.NotFoundException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by 3604290 on 03/05/17.
 */
public class MeetPointBusiness {

    private final DAO<User> userDAO = new DAO<>();
    private final DAO<MeetPoint> meetPointDAO = new DAO<>();

    public MeetPointDTO createMeetPoint(MeetPoint meetPoint) {
        if (meetPointDAO.getOne(MeetPoint.class, "id", meetPoint.getOurId()) != null) {
            throw new BadRequestException();
        }
        return meetPointDAO.save(meetPoint).toDTO();
    }

    public List<MeetPointDTO> getMeetPoints(String email) {
        if (userDAO.getOne(User.class, "email", email) == null) {
            throw new NotFoundException();
        }
        List<MeetPointDTO> meetPoints = new ArrayList<>();
        for (MeetPoint meetPoint : meetPointDAO.getAll(MeetPoint.class, "emailUser", email)) {
            meetPoints.add(meetPoint.toDTO());
        }
        return meetPoints;
    }

    public MeetPointDTO updateMeetPoint(MeetPoint m) {
        MeetPoint meetPoint = meetPointDAO.getOne(MeetPoint.class, "id", m.getOurId());
        if (meetPointDAO.getOne(MeetPoint.class, "id", meetPoint.getOurId()) == null)
            throw new NotFoundException();
        meetPoint.setName(m.getName());
        meetPoint.setAdress(m.getAdress());
        meetPoint.setPostalCode(m.getPostalCode());
        meetPoint.setTown(m.getTown());
        meetPoint.setLatitude(m.getLatitude());
        meetPoint.setLongitude(m.getLongitude());
        meetPoint.setEmailUser(m.getEmailUser());
        return meetPointDAO.save(meetPoint).toDTO();
    }

    public void removeMeetPoint(String id) {
        meetPointDAO.delete(MeetPoint.class, "id", id);
    }
}
