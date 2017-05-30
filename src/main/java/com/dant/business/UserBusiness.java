package com.dant.business;

import com.dant.dao.DAO;
import com.dant.entity.Friendship;
import com.dant.entity.User;
import com.dant.entity.dto.UserDTO;
import com.dant.util.MongoUtil;

import javax.ws.rs.BadRequestException;
import javax.ws.rs.ForbiddenException;
import javax.ws.rs.NotFoundException;

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
        if (!user.getPassword().equals(u.getPassword())) {
            throw new ForbiddenException();
        }
        user.setToken(MongoUtil.generateToken());
        return userDAO.save(user).toDTO();
    }

    public UserDTO createUser(User user) {
        if (userDAO.getOne(User.class, "email", user.getEmail()) != null) {
            throw new BadRequestException();
        }
        user.setToken(MongoUtil.generateToken());
        return userDAO.save(user).toDTO();
    }

    public UserDTO updateUser(User u) {
        User user = UtilBusiness.checkToken(u.getToken());
        if (user == null) {
            throw new NotFoundException();
        }
        user.setName(u.getName());
        user.setPassword(u.getPassword());
        return userDAO.save(user).toDTO();
    }

    public void removeUser(String token) {
        UtilBusiness.checkToken(token);
        userDAO.delete(User.class, "token", token);
    }
}
