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
    private double longitude;
    private double latitude;
    private long time;
    //jodaime
    @Reference
    private User user;

    public Position(double longitude, double latitude, long time, User user) {
        this.longitude = longitude;
        this.latitude = latitude;
        this.time = time;
        this.user = user;
    }

    public ObjectId getId() {
        return id;
    }

    public double getLongitude() {
        return longitude;
    }

    public double getLatitude() {
        return latitude;
    }

    public long getTime() {
        return time;
    }

    public User getUser() {
        return user;
    }
}
