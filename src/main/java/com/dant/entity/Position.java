package com.dant.entity;

import com.dant.entity.dto.PositionDTO;
import org.bson.types.ObjectId;
import org.joda.time.DateTime;
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
    private long time;
    private String emailUser;

    public Position(double latitude, double longitude, long time, String emailUser) {
        this.latitude = latitude;
        this.longitude = longitude;
        this.time = time;
        this.emailUser = emailUser;
    }

    public Position() {

    }

//    public Position(double latitude, double longitude, int year, int month, int day, int hour, int minute, int second, int milli) {
//        this.latitude = latitude;
//        this.longitude = longitude;
//        this.time = new DateTime(year, month, day, hour, minute, second, milli);
//    }

    public PositionDTO toDTO() { return new PositionDTO(latitude, longitude, time, emailUser); }

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

    public String getEmailUser() {
        return emailUser;
    }

    public void setEmailUser(String emailUser) {
        this.emailUser = emailUser;
    }

    @Override
    public String toString() {
        return "Latitude : " + latitude + ", longitude : " + longitude + ", time : " + time + ", emailUser : " + emailUser;
    }

    public static void main(String[] args) {
        DateTime testTime = new DateTime(1000000);
        System.out.println(testTime.toString("E MM/dd/yyyy HH:mm:ss.SSS"));
        System.out.println(testTime.getMillis());
        System.out.println(DateTime.now().toString("E MM/dd/yyyy HH:mm:ss.SSS"));
        System.out.println(DateTime.now().getMillis());
    }

}
