package com.dant.entity;

import com.dant.entity.dto.UserDTO;
import org.bson.types.ObjectId;
import org.mongodb.morphia.annotations.Entity;
import org.mongodb.morphia.annotations.Id;
import org.mongodb.morphia.annotations.Reference;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by pitton on 2017-02-21.
 */
@Entity
public class User implements Serializable {

    @Id
    private ObjectId id;
    private String name;
    // TODO: Indexer email?
    private String email;
    private String password;
    // TODO: Indexer token (hashcode)
    private String token;
    @Reference
    private List<MeetPoint> meetPoints;
    @Reference
    private List<Position> positions;

    public User(String name, String email, String password, String token, List<MeetPoint> meetPoints, List<Position> positions) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.token = token;
        this.meetPoints = meetPoints;
        this.positions = positions;
    }
    
    public User(String name, String email, String password) {
        this(name, email, password, "", new ArrayList<MeetPoint>(), new ArrayList<Position>());
        this.email = email;
        this.password = password;
    }

    public User() {

    }

    public UserDTO toDTO() {
        return new UserDTO(name, email, token);
    }

    public ObjectId getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public List<MeetPoint> getMeetPoints() {
        return meetPoints;
    }

    public void addMeetPoint(MeetPoint meetPoint) {
        meetPoints.add(meetPoint);
    }

    public void setMeetPoints(List<MeetPoint> meetPoints) {
        this.meetPoints = meetPoints;
    }

    public List<Position> getPositions() {
        return positions;
    }

    public void addPosition(Position position) {
        positions.add(position);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        User user = (User) o;
        return email.equals(user.email);
    }

    @Override
    public int hashCode() {
        return email.hashCode();
    }

    @Override
    public String toString() {
        return email;
    }

}
