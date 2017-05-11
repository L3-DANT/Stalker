package com.dant.entity.dto;

/**
 * Created by 3502804 on 10/05/17.
 */
public class FriendshipDTO {
    public String userSource;
    public String userDest;
    public boolean isAccepted;

    public FriendshipDTO(String userSource, String userDest, boolean isAccepted) {
        this.userSource = userSource;
        this.userDest = userDest;
        this.isAccepted = isAccepted;
    }
}
