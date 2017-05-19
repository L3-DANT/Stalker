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

    public MeetPointDTO createMeetPoint(String userToken, String name, String address, int postalCode, String town, double latitude, double longitude) {
        User user = userDAO.getOne(User.class, "token", userToken);
        if (user == null) {
            throw new BadRequestException();
        }
        MeetPoint meetPoint = meetPointDAO.getOne(MeetPoint.class, "address", address, "user", user);
        if (meetPoint != null) {
            throw new BadRequestException();
        }
        return meetPointDAO.save(new MeetPoint(name, address, postalCode, town, latitude, longitude)).toDTO();
    }

    public List<MeetPointDTO> getMeetPoints(String token) {
        User user = userDAO.getOne(User.class, "token", token);
        if (user == null) {
            throw new NotFoundException();
        }
        List<MeetPointDTO> meetPoints = new ArrayList<>();
        for (MeetPoint meetPoint : user.getMeetPoints()) {
            meetPoints.add(meetPoint.toDTO());
        }
        return meetPoints;
    }

    public MeetPointDTO updateMeetPoint(String id, String name, String address, int postalCode, String town, double latitude, double longitude) {
        MeetPoint meetPoint = meetPointDAO.getOne(MeetPoint.class, "id", id);
        if (meetPoint == null) {
            throw new BadRequestException();
        }
        meetPoint.setName(name);
        meetPoint.setAdress(address);
        meetPoint.setPostalCode(postalCode);
        meetPoint.setTown(town);
        meetPoint.setLatitude(latitude);
        meetPoint.setLongitude(longitude);
        return meetPointDAO.save(meetPoint).toDTO();
    }

    public void removeMeetPoint(String id) {
        meetPointDAO.delete(MeetPoint.class, "id", id);
    }

    // Pas utilisé
    public MeetPoint getMeetPoint(String address, String userToken) {
        User user = userDAO.getOne(User.class, "token", userToken);
        if (user == null) {
            throw new BadRequestException();
        }
        // TODO: get meetPoint
        // Comment identifier un meetPoint
        return new MeetPoint();
    }
}
