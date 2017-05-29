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
    private ObjectId mongoId;       // Id for mongoDb
    private String id;              // Id for
    private String name;
    private String address;
    private int postalCode;
    private String town;
    private double latitude;
    private double longitude;
    private String emailUser;

    public MeetPoint(String id, String name, String address, int postalCode, String town, double latitude, double longitude, String emailUser) {
        this.id = id;
        this.name = name;
        this.address = address;
        this.postalCode = postalCode;
        this.town = town;
        this.latitude = latitude;
        this.longitude = longitude;
        this.emailUser = emailUser;
    }

    public MeetPoint(String name, String address, int postalCode, String town, double latitude, double longitude, String emailUser) {
        this(RandomStringUtils.random(32, true, true), name, address, postalCode, town, latitude, longitude, emailUser);
    }

    public MeetPoint() {
    }

    public MeetPointDTO toDTO() { return new MeetPointDTO(id, name, address, postalCode, town, latitude, longitude, emailUser); }

    public ObjectId getId() {
        return mongoId;
    }

    public String getOurId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public void setAdress(String name) {
        this.name = name;
    }

    public void setName(String address) {
        this.address = address;
    }

    public String getAdress() {
        return address;
    }

    public int getPostalCode() {
        return postalCode;
    }

    public void setPostalCode(int postalCode) {
        this.postalCode = postalCode;
    }

    public String getTown() {
        return town;
    }

    public void setTown(String town) {
        this.town = town;
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

    public String getEmailUser() {
        return emailUser;
    }

    public void setEmailUser(String emailUser) {
        this.emailUser = emailUser;
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
