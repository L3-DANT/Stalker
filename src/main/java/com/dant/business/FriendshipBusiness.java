package com.dant.business;

import com.dant.dao.DAO;
import com.dant.entity.*;
import com.dant.entity.dto.*;

import javax.ws.rs.BadRequestException;
import javax.ws.rs.NotFoundException;

import java.util.ArrayList;
import java.util.List;
/**
 * Created by 3502804 on 10/05/17.
 */
public class FriendshipBusiness {
    private final DAO<User> userDAO = new DAO<>();
    private final DAO<Friendship> friendshipDAO = new DAO<>();

    public FriendshipDTO askFriend(Friendship friendship) {
        System.out.println("Friendship : " + friendship);
        if(userDAO.getOne(User.class, "email", friendship.getEmailSource()) == null && userDAO.getOne(User.class, "email", friendship.getEmailDest()) == null)
            throw new NotFoundException();
        if(friendshipDAO.getOne(Friendship.class, "emailSource", friendship.getEmailSource(), "emailDest", friendship.getEmailDest()) != null && friendshipDAO.getOne(Friendship.class, "emailSource", friendship.getEmailDest(), "emailDest", friendship.getEmailSource()) != null)
            throw new BadRequestException();
        return friendshipDAO.save(friendship).toDTO();
    }

    public FriendshipDTO acceptFriend(Friendship f) {
        System.out.println("Friendship : " + f);
        if(userDAO.getOne(User.class, "email", f.getEmailSource()) == null && userDAO.getOne(User.class, "email", f.getEmailDest()) == null)
            throw new NotFoundException();
        Friendship friendship = friendshipDAO.getOne(Friendship.class, "emailSource", f.getEmailSource(), "emailDest", f.getEmailDest());
        if(friendship == null)
            throw new NotFoundException();
        friendship.accepte();
        return friendshipDAO.save(friendship).toDTO();
    }

    public List<UserDTO> getFriends(String email) {
        User user = userDAO.getOne(User.class, "email", email);
        if (user == null)
            throw new NotFoundException();
        List<UserDTO> friendsDTO = new ArrayList<>();
        for(Friendship friendship : friendshipDAO.getAll(Friendship.class, "friendSource", email)) {
            if(friendship.isAccepted()){
                User friend = userDAO.getOne(User.class, "email", friendship.getEmailDest());
                if(friend != null)
                    friendsDTO.add(friend.toDTO());
            }
        }
        for(Friendship friendship : friendshipDAO.getAll(Friendship.class, "friendDest", email)) {
            if(friendship.isAccepted()){
                User friend = userDAO.getOne(User.class, "email", friendship.getEmailSource());
                if(friend != null)
                    friendsDTO.add(friend.toDTO());
            }
        }
        return friendsDTO;
    }

    public List<UserDTO> getDemands(String email) {
        User user = userDAO.getOne(User.class, "email", email);
        if (user == null)
            throw new NotFoundException();
        List<UserDTO> friends = new ArrayList<>();
        for(Friendship friendship : friendshipDAO.getAll(Friendship.class, "friendDest", email)) {
            if(!friendship.isAccepted()){
                User friend = userDAO.getOne(User.class, "email", friendship.getEmailSource());
                if(friend != null)
                    friends.add(friend.toDTO());
            }
        }
        return friends;
    }


    public void removeFriendship(String friendSource, String friendDest) {
        friendshipDAO.delete(Friendship.class, "friendSource", friendSource, "friendDest", friendDest);
    }
}
