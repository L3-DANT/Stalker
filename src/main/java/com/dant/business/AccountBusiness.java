package com.dant.business;

import com.dant.dao.DAO;
import com.dant.entity.Account;

/**
 * Created by 3502804 on 02/03/17.
 */
public class AccountBusiness {

    private final DAO<Account> accountDAO = new DAO<>();

    public Account create(String email) {
        Account account = new Account(email);
        return accountDAO.save(account);
    }

    public Account getAccount(String email) {
        return accountDAO.get(Account.class, "email", email);
    }

}
