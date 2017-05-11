package com.dant.business;

import com.dant.dao.DAO;
import com.dant.entity.MeetPoint;
import com.dant.entity.User;

import javax.ws.rs.BadRequestException;
import java.util.List;

/**
 * Created by 3604290 on 03/05/17.
 */
public class MeetPointBusiness {

    private final DAO<User> userDAO = new DAO<>();
    private final DAO<MeetPoint> meetPointDAO = new DAO<>();

    public MeetPoint createMeetPoint(String name, String address, double latitude, double longitude, boolean favorite, String userToken) {
        User user = userDAO.getOne(User.class, "token", userToken);
        if (user == null) {
            throw new BadRequestException();
        }
        MeetPoint meetPoint = meetPointDAO.getOne(MeetPoint.class, "address", address, "user", user);
        if (meetPoint != null) {
            throw new BadRequestException();
        }
        return meetPointDAO.save(new MeetPoint(name, address, latitude, longitude, favorite, user));
    }

    public void updateMeetPoint(String name, String address, double latitude, double longitude, boolean favorite, String userToken) {
        User user = userDAO.getOne(User.class, "token", userToken);
        if (user == null) {
            throw new BadRequestException();
        }
        // TODO: update meetPoint

    }

    public void removeMeetPoint(String address, String userToken) {
        User user = userDAO.getOne(User.class, "token", userToken);
        if (user == null) {
            throw new BadRequestException();
        }
        // TODO: delete meetPoint

    }

    public MeetPoint getMeetPoint(String address, String userToken) {
        User user = userDAO.getOne(User.class, "token", userToken);
        if (user == null) {
            throw new BadRequestException();
        }
        // TODO: get meetPoint
        // Comment identifier un meetPoint
        return new MeetPoint();
    }

    public List<MeetPoint> getAllMeetPoints(String userToken) {
        User user = userDAO.getOne(User.class, "token", userToken);
        if (user == null) {
            throw new BadRequestException();
        }
        return meetPointDAO.getAll(MeetPoint.class, "user", user);
    }

}
