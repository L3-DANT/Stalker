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

    public UserDTO authenticate(User u) {
        User user = userDAO.getOne(User.class, "email", u.getEmail());
        if (user == null) {
            throw new NotFoundException();
        }
        boolean validPassword = user.getPassword().equals(u.getPassword());
        if (!validPassword) {
            throw new ForbiddenException();
        }
        user.setToken(MongoUtil.generateToken());
        return userDAO.save(user).toDTO();
    }

    public UserDTO createUser(User user) {
        System.out.println("User : " + user);
        System.out.println(userDAO.getAll(User.class));
        if (userDAO.getOne(User.class, "email", user.getEmail()) != null) {
            System.out.println("Késsé ? : " +userDAO.getOne(User.class, "email", user.getEmail()));
            throw new BadRequestException();
        }
        System.out.println("Normalement on vient pas ici");
        user.setToken(MongoUtil.generateToken());
        return userDAO.save(user).toDTO();
    }

    public UserDTO updateUser(User u) {
        User user = userDAO.getOne(User.class, "email", u.getEmail());
        if (user == null) {
            throw new NotFoundException();
        }
        user.setName(u.getName());
        user.setPassword(u.getPassword());
        return userDAO.save(user).toDTO();
    }

    public void removeUser(String email) {
        userDAO.delete(User.class, "email", email);
    }
}
