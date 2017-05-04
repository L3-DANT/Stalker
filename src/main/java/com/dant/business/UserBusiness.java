package com.dant.business;

import com.dant.dao.DAO;
import com.dant.entity.User;

import javax.ws.rs.BadRequestException;
import javax.ws.rs.ForbiddenException;
import javax.ws.rs.NotFoundException;
import java.math.BigInteger;
import java.security.SecureRandom;

/**
 * Created by 3502804 on 02/03/17.
 */
public class UserBusiness {

    private final DAO<User> userDAO = new DAO<>();

    public User authenticate(String email, String password) {
        User user = userDAO.getOne(User.class, "email", email);
        if (user == null) {
            throw new NotFoundException();
        }
        boolean validPassword = user.getPassword().equals(password);
        if (!validPassword) {
            throw new ForbiddenException();
        }
        user.setToken(new BigInteger(130, new SecureRandom()).toString(32));
        userDAO.save(user);
        return user;
    }

    public User createUser(String name, String email, String password) {
        User user = userDAO.getOne(User.class, "email", email);
        if (user != null) {
            throw new BadRequestException();
        }
        return userDAO.save(new User(name, email, password));
    }

    public User updateUser(String name, String email, String password, String token) {
        User user = userDAO.getOne(User.class, "token", token);
        if (user == null) {
            throw new NotFoundException();
        }
        user.setName(name);
        // TODO: tester unicité email
        user.setEmail(email);
        user.setPassword(password);
        return userDAO.save(user);
    }

    public void removeUser(String token) {
        userDAO.delete(User.class, "token", token);
    }

    public User getUser(String token) {
        User user = userDAO.getOne(User.class, "token", token);
        if (user == null) {
            throw new NotFoundException();
        }
        return user;
    }

}
