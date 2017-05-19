package com.dant.business;

import com.dant.dao.DAO;
import com.dant.entity.Friendship;
import com.dant.entity.MeetPoint;
import com.dant.entity.User;
import com.dant.entity.dto.FriendshipDTO;
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
    private final DAO<Friendship> friendshipDAO = new DAO<>();

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

//    public List<UserDTO> getFriends(String token) {
//        User user = userDAO.getOne(User.class, "token", token);
//        if (user == null) {
//            throw new NotFoundException();
//        }
//        List<UserDTO> friendsToSend = new ArrayList<>();
//
//        for (Friendship friendship : friendshipDAO.getAll(Friendship.class, "friendSource", user)) {
//            friendship.getFriendSource().setToken(null);
//            friendsToSend.add(friendship.getFriendSource().toDTO());
//        }
//        for (Friendship friendship : friendshipDAO.getAll(Friendship.class, "friendDest", user)) {
//            friendship.getFriendSource().setToken(null);
//            friendsToSend.add(friendship.getFriendSource().toDTO());
//        }
//        return friendsToSend;
//    }
}
