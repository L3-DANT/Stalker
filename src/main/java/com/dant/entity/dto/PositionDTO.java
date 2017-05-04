package com.dant.entity.dto;

import java.io.Serializable;

/**
 * Created by 3604290 on 04/05/17.
 */
public class PositionDTO implements Serializable {

    public double latitude;
    public double longitude;
    //jodatime
    public long time;
    public String token;

    public PositionDTO() {
    }

    public PositionDTO(double latitude, double longitude, long time, String token) {
        this.latitude = latitude;
        this.longitude = longitude;
        this.time = time;
        this.token = token;
    }

}
