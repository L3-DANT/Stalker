package com.dant.entity;

import com.dant.entity.dto.MeetPointDTO;
import org.apache.commons.lang.RandomStringUtils;
import org.bson.types.ObjectId;
import org.mongodb.morphia.annotations.*;

import java.io.Serializable;

/**
 * Created by 3502804 on 29/03/17.
 */
public class MeetPoint implements Serializable {

    @Id
//    private ObjectId mongoId;
//    private String id;
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
        this.latitude = latitude;
        this.longitude = longitude;
        this.favorite = favorite;
        this.user = user;
//        this.id = RandomStringUtils.random(32, true, true);
    }

    public MeetPoint() {
    }

    public MeetPointDTO toDTO() { return new MeetPointDTO(name, address, latitude, longitude, favorite); }

    public ObjectId getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public void setName(String address) {
        this.address = address;
    }

    public String getAdress() {
        return address;
    }

    public void setAdress(String name) {
        this.name = name;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

    public boolean getFavorite() {
        return favorite;
    }

    public void setFavorite(boolean favorite) {
        this.favorite = favorite;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        MeetPoint meetPoint = (MeetPoint) o;
        // TODO: check user
        return address.equals(meetPoint.address);
    }

    @Override
    public int hashCode() {
        return address.hashCode();
    }

    @Override
    public String toString() {
        return name;
    }

}
