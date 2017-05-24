package com.dant.entity.dto;

import org.joda.time.DateTime;

import java.io.Serializable;

/**
 * Created by 3604290 on 04/05/17.
 */
public class PositionDTO implements Serializable {

    public double latitude;
    public double longitude;
    private long time;
    public String emailUser;

    public PositionDTO() {
    }

    public PositionDTO(double latitude, double longitude, long time, String emailUser) {
        this.latitude = latitude;
        this.longitude = longitude;
        this.time = time;
        this.emailUser = emailUser;
    }

}
