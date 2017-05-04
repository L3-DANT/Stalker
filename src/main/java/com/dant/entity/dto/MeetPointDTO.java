package com.dant.entity.dto;

import java.io.Serializable;

/**
 * Created by 3604290 on 03/05/17.
 */
public class MeetPointDTO implements Serializable {

    public String name;
    public String address;
    public double latitude;
    public double longitude;
    public boolean favorite;

    public MeetPointDTO() {
    }

    public MeetPointDTO(String name, String address, double latitude, double longitude, boolean favorite) {
        this.name = name;
        this.address = address;
        this.latitude = latitude;
        this.longitude = longitude;
        this.favorite = favorite;
    }

}
