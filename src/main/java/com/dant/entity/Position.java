package com.dant.entity;

import org.bson.types.ObjectId;
import org.mongodb.morphia.annotations.*;

/**
 * Created by 3502804 on 29/03/17.
 */
@Entity
public class Position {

    @Id
    private ObjectId id;
    private double latitude;
    private double longitude;
    //jodatime
    private long time;
    @Reference
    private User user;

    public Position(double latitude, double longitude, long time, User user) {
        this.latitude = latitude;
        this.longitude = longitude;
        this.time = time;
        this.user = user;
    }

    public ObjectId getId() {
        return id;
    }

    public double getLatitude() {
        return latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public long getTime() {
        return time;
    }

    public User getUser() {
        return user;
    }

}
