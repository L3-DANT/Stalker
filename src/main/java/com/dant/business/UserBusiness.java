package com.dant.business;

import com.dant.dao.DAO;
import com.dant.entity.User;

/**
 * Created by 3502804 on 02/03/17.
 */
public class UserBusiness {

    private final DAO<User> accountDAO = new DAO<>();

    public User create(String email) {
        User account = new User(email);
        return accountDAO.save(account);
    }

    public User getAccount(String email) {
        return accountDAO.get(User.class, "email", email);
    }

}
