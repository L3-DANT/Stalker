package com.dant.entity.dto;

import java.io.Serializable;

/**
 * Created by 3604290 on 03/05/17.
 */
public class UserDTO implements Serializable {

    public String name;
    public String email;
    public String token;
    public PositionDTO lastPosition;

    public UserDTO() {
    }

    public UserDTO(String name, String email, String token, double latitude, double longitude, long time) {
        this.name = name;
        this.email = email;
        this.token = token;
        this.lastPosition = new PositionDTO(latitude, longitude, time, email);
    }

    public UserDTO(String name, String email, double latitude, double longitude, long time) {
        this(name, email, "", latitude, longitude, time);
    }

    public UserDTO(String name, String email, String token) {
        this(name, email, token, 0.0, 0.0, 0);
    }

    public UserDTO(String name, String email) {
        this(name, email, "");
    }

}
