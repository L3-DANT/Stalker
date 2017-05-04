package com.dant.entity.dto;

import java.io.Serializable;

/**
 * Created by 3604290 on 03/05/17.
 */
public class UserDTO implements Serializable {

    public String name;
    public String email;
    public String token;

    public UserDTO() {
    }

    public UserDTO(String name, String email, String token) {
        this.name = name;
        this.email = email;
        this.token = token;
    }

}
