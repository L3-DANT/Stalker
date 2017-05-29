package com.dant.entity.dto;

import java.io.Serializable;

/**
 * Created by 3604290 on 03/05/17.
 */
public class MeetPointDTO implements Serializable {

    public String id;
    public String name;
    public String address;
    public int postalCode;
    public String town;
    public double latitude;
    public double longitude;
    public String emailUser;

    public MeetPointDTO() {
    }

    public MeetPointDTO(String id, String name, String address, int postalCode, String town, double latitude, double longitude, String emailUser) {
        this.id = id;
        this.name = name;
        this.address = address;
        this.postalCode = postalCode;
        this.town = town;
        this.latitude = latitude;
        this.longitude = longitude;
        this.emailUser = emailUser;
    }

}
