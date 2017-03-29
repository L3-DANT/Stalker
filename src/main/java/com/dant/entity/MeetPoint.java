package com.dant.entity;

import org.bson.types.ObjectId;

/**
 * Created by 3502804 on 29/03/17.
 */
public class MeetPoint {
    private ObjectId id;
    private String name;
    private String address;
    private double latitude;
    private double longitude;
    private boolean favorite;
    private User user;

    public ObjectId getId() { return id; }

    public void setId(ObjectId id) { this.id = id; }

    public String getName() { return name; }

    public void setName(String name) { this.name = name; }

    public double getLatitude() { return latitude; }

    public void setLatitude(double latitude) { this.latitude = latitude; }

    

}
