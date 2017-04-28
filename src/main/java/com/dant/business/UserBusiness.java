package com.dant.business;

import com.dant.dao.DAO;
import com.dant.entity.User;

import java.util.List;

/**
 * Created by 3502804 on 02/03/17.
 */
public class UserBusiness {

    private final DAO<User> userDAO = new DAO<>();

    public User create(String email, String name) {
        if(userDAO.getOne(User.class, "email", email) == null) {
            return userDAO.save(new User(name, email));
        }
        return null;
    }

    public User getAccount(String email) {
        return userDAO.getOne(User.class, "email", email);
    }

    public List<User> getFriends(String email) {
        //a modifier
        return userDAO.getAll(User.class, "email", email);
    }
}
