package com.dant.entity;

import com.dant.entity.dto.*;
import org.bson.types.ObjectId;
import org.mongodb.morphia.annotations.*;

import java.io.Serializable;

/**
 * Created by 3502804 on 10/05/17.
 */
@Entity
public class Friendship implements Serializable {

    @Id
    private ObjectId id;

    @Reference
    private String emailSource;
    @Reference
    private String emailDest;

    private boolean isAccepted;

    public Friendship(String friendSource, String friendDest, boolean isAccepted) {
        this.emailSource = friendSource;
        this.emailDest = friendDest;
        this.isAccepted = isAccepted;
    }

    public Friendship(String friendSource, String friendDest) {
        this(friendSource, friendDest, false);
    }

    public String getEmailSource() {
        return emailSource;
    }

    public String getEmailDest() {
        return emailDest;
    }

    public boolean isAccepted() {
        return isAccepted;
    }

    public void accepte() {
        isAccepted = true;
    }

    public FriendshipDTO toDTO() {
        return new FriendshipDTO(emailSource, emailDest, isAccepted);
    }
}
