package com.dant.business;

import com.dant.dao.DAO;
import com.dant.entity.MeetPoint;
import com.dant.entity.User;
import com.dant.entity.dto.MeetPointDTO;
import com.dant.entity.dto.UserDTO;
import com.dant.util.MongoUtil;

import javax.ws.rs.BadRequestException;
import javax.ws.rs.ForbiddenException;
import javax.ws.rs.NotFoundException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by 3502804 on 02/03/17.
 */
public class UserBusiness {

    private final DAO<User> userDAO = new DAO<>();

    public UserDTO getUser(String token) {
        User user = userDAO.getOne(User.class, "token", token);
        if (user == null) {
            throw new NotFoundException();
        }
        return user.toDTO();
    }

    public UserDTO authenticate(String email, String password) {
        User user = userDAO.getOne(User.class, "email", email);
        if (user == null) {
            throw new NotFoundException();
        }
        boolean validPassword = user.getPassword().equals(password);
        if (!validPassword) {
            throw new ForbiddenException();
        }
        user.setToken(MongoUtil.generateToken());
        return userDAO.save(user).toDTO();
    }

    public UserDTO createUser(String name, String email, String password) {
        User user = userDAO.getOne(User.class, "email", email);
        if (user != null) {
            throw new BadRequestException();
        }
        user = new User(name, email, password);
        user.setToken(MongoUtil.generateToken());
        return userDAO.save(user).toDTO();
    }

    public UserDTO updateUser(String name, String email, String password, String token) {
        User user = userDAO.getOne(User.class, "token", token);
        if (user == null) {
            throw new NotFoundException();
        }
        if (userDAO.getOne(User.class, "email", email) != null) {
            throw new BadRequestException();
        }
        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);
        return userDAO.save(user).toDTO();
    }

    public void removeUser(String token) {
        userDAO.delete(User.class, "token", token);
    }

    public List<UserDTO> getFriends(String token) {
        User user = userDAO.getOne(User.class, "token", token);
        if (user == null) {
            throw new NotFoundException();
        }
        List<UserDTO> friends = new ArrayList<>();
        for (User friend : user.getFriends()) {
            friend.setToken(null);
            friends.add(friend.toDTO());
        }
        return friends;
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

}
