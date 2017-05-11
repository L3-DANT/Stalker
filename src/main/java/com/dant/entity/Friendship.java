package com.dant.entity;

import com.dant.entity.dto.FriendshipDTO;
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
    private User friendSource;
    @Reference
    private User friendDest;

    private boolean isAccepted;

    public Friendship(User friendSource, User friendDest, boolean isAccepted) {
        this.friendSource = friendSource;
        this.friendDest = friendDest;
        this.isAccepted = isAccepted;
    }

    public Friendship(User friendSource, User friendDest) {
        this(friendSource, friendDest, false);
    }

    public User getFriendSource() {
        return friendSource;
    }

    public User getFriendDest() {
        return friendDest;
    }

    public boolean isAccepted() {
        return isAccepted;
    }

    public void accepte() {
        isAccepted = true;
    }

    public FriendshipDTO toDTO() {
        return new FriendshipDTO(friendSource.getEmail(), friendDest.getEmail(), isAccepted);
    }
}
