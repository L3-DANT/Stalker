package com.dant.business;

import com.dant.dao.DAO;
import com.dant.entity.*;
import com.dant.entity.dto.*;
import javax.ws.rs.NotFoundException;

import java.util.ArrayList;
import java.util.List;
/**
 * Created by 3502804 on 10/05/17.
 */
public class FriendshipBusiness {
    private final DAO<User> userDAO = new DAO<>();
    private final DAO<Friendship> friendshipDAO = new DAO<>();

    public FriendshipDTO askFriend(String friendSource, String friendDest) {
        User userSource = userDAO.getOne(User.class, "email", friendSource);
        User userDest = userDAO.getOne(User.class, "email", friendDest);
        // test existence amitié ?
        if(userSource != null && userDest != null)
            throw new NotFoundException();
        else {
            Friendship friendship = new Friendship(userSource, userDest);
            return friendshipDAO.save(friendship).toDTO();
        }
    }

    public FriendshipDTO acceptFriend(String friendsource, String friendDest) {
        Friendship friendship = friendshipDAO.getOne(Friendship.class, "friendSource", friendsource, "friendDest", friendDest);
        if(friendship != null)
            throw new NotFoundException();
        else
            friendship.accepte();
        return friendshipDAO.save(friendship).toDTO();
    }

    public List<UserDTO> getFriends(String email) {
        User user = userDAO.getOne(User.class, "email", email);
        if (user == null)
            throw new NotFoundException();
        List<UserDTO> friendsDTO = new ArrayList<>();
        List<Friendship> friends = friendshipDAO.getAll(Friendship.class, "friendSource", email);;
        for(Friendship fs : friends) {
            if(fs.isAccepted()){
                User friend = userDAO.getOne(User.class, "email", fs.getFriendDest().getEmail());
                if(friend != null)
                    friendsDTO.add(friend.toDTO());
            }
        }
        friends = friendshipDAO.getAll(Friendship.class, "friendDest", email);;
        for(Friendship fs : friends) {
            if(fs.isAccepted()){
                User friend = userDAO.getOne(User.class, "email", fs.getFriendSource().getEmail());
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
        List<UserDTO> friendsDTO = new ArrayList<>();
        List<Friendship> friends = friendshipDAO.getAll(Friendship.class, "friendDest", email);;
        for(Friendship fs : friends) {
            if(!fs.isAccepted()){
                User friend = userDAO.getOne(User.class, "email", fs.getFriendSource().getEmail());
                if(friend != null)
                    friendsDTO.add(friend.toDTO());
            }
        }
        return friendsDTO;
    }


    public void removeFriendship(String friendSource, String friendDest) {
        friendshipDAO.delete(Friendship.class, "friendSource", friendSource, "friendDest", friendDest);
    }
}
