package com.dant.entity;

import org.bson.types.ObjectId;
import org.mongodb.morphia.annotations.*;

/**
 * Created by 3502804 on 29/03/17.
 */
public class MeetPoint {
    @Id
    private ObjectId id;
    private String name;
    private String address;
    private double latitude;
    private double longitude;
    private boolean favorite;
    @Reference
    private User user;

    public MeetPoint(String name, String address, double latitude, double longitude, boolean favorite, User user) {
        this.name = name;
        this.address = address;
        this.longitude = longitude;
        this.latitude = latitude;
        this.favorite = favorite;
        this.user = user;
    }

    public ObjectId getId() { return id; }

    public String getName() { return name; }

    public void setAdress(String name) { this.name = name; }

    public String getAdress() { return address; }

    public void setName(String address) { this.address = address; }

    public double getLatitude() { return latitude; }

    public void setLatitude(double latitude) { this.latitude = latitude; }

    public double getLongitude() { return longitude; }

    public void setLongitude(double longitude) { this.longitude = longitude; }

    public boolean getFavorite() { return favorite; }

    public void setFavorite(boolean favorite) { this.favorite = favorite; }

    public User getUser() { return user; }

    public void setUser(User user) { this.user = user; }
}
