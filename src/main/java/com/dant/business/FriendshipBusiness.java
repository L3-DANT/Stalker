package com.dant.business;

import com.dant.dao.DAO;
import com.dant.entity.*;
import com.dant.entity.dto.*;

import javax.ws.rs.BadRequestException;
import javax.ws.rs.ForbiddenException;
import javax.ws.rs.NotFoundException;

import java.util.ArrayList;
import java.util.List;
/**
 * Created by 3502804 on 10/05/17.
 */
public class FriendshipBusiness {
    private final DAO<User> userDAO = new DAO<>();
    private final DAO<Friendship> friendshipDAO = new DAO<>();

    public FriendshipDTO askFriend(String token, Friendship friendship) {
        User asker = UtilBusiness.checkToken(token);
        if(!asker.getEmail().equals(friendship.getEmailSource()))
            throw new ForbiddenException();         // If someone try to ask for friend in the name of someone else
        if(userDAO.getOne(User.class, "email", friendship.getEmailDest()) == null)
            throw new NotFoundException();          // If the asked user don't exist
        if(asker.getEmail().equals(friendship.getEmailDest()))
            throw new NotFoundException();          // If someone try to be his own friend
        if(friendshipDAO.getOne(Friendship.class, "emailSource", friendship.getEmailSource(), "emailDest", friendship.getEmailDest()) != null && friendshipDAO.getOne(Friendship.class, "emailSource", friendship.getEmailDest(), "emailDest", friendship.getEmailSource()) != null)
            throw new BadRequestException();        // If friendship exist with same or invers users
        return friendshipDAO.save(friendship).toDTO();
    }

    public FriendshipDTO acceptFriend(String token, Friendship f) {
        User asked = UtilBusiness.checkToken(token);
        if(!asked.getEmail().equals(f.getEmailDest()))
            throw new ForbiddenException();
        if(userDAO.getOne(User.class, "email", f.getEmailSource()) == null)
            throw new NotFoundException();
        Friendship friendship = friendshipDAO.getOne(Friendship.class, "emailSource", f.getEmailSource(), "emailDest", f.getEmailDest());
        if(friendship == null)
            throw new NotFoundException();
        friendship.accepte();
        return friendshipDAO.save(friendship).toDTO();
    }

    public List<UserDTO> getFriends(String token) {
        User user = UtilBusiness.checkToken(token);
        List<UserDTO> friends = new ArrayList<>();
        for(Friendship friendship : friendshipDAO.getAll(Friendship.class, "emailSource", user.getEmail())) {
            if(friendship.isAccepted()){
                User friend = userDAO.getOne(User.class, "email", friendship.getEmailDest());
                if(friend != null)
                    friends.add(friend.toDTOWithLastPosition(UtilBusiness.getLastPosition(friend.getEmail())));
            }
        }
        for(Friendship friendship : friendshipDAO.getAll(Friendship.class, "emailDest", user.getEmail())) {
            if(friendship.isAccepted()){
                User friend = userDAO.getOne(User.class, "email", friendship.getEmailSource());
                if(friend != null)
                    friends.add(friend.toDTOWithLastPosition(UtilBusiness.getLastPosition(friend.getEmail())));
            }
        }
        return friends;
    }

    public List<UserDTO> getDemands(String token) {
        User user = UtilBusiness.checkToken(token);
        List<UserDTO> demands = new ArrayList<>();
        for(Friendship friendship : friendshipDAO.getAll(Friendship.class, "emailDest", user.getEmail())) {
            if(!friendship.isAccepted()){
                User friend = userDAO.getOne(User.class, "email", friendship.getEmailSource());
                if(friend != null)
                    demands.add(friend.toDTOWithLastPosition(UtilBusiness.getLastPosition(friend.getEmail())));
            }
        }
        return demands;
    }

    public void removeFriendship(String token, Friendship friendship) {
        User user = UtilBusiness.checkToken(token);
        if(!user.getEmail().equals(friendship.getEmailSource()) && !user.getEmail().equals(friendship.getEmailDest()))
            throw new ForbiddenException();
        friendshipDAO.delete(Friendship.class, "emailSource", friendship.getEmailSource(), "emailDest", friendship.getEmailDest());
    }

    public List<UserDTO> getFriendShips(String token) {
        User user = UtilBusiness.checkToken(token);
        List<UserDTO> friendships = new ArrayList<>();
        for(Friendship friendship : friendshipDAO.getAll(Friendship.class, "emailSource", user.getEmail())) {
            User friend = userDAO.getOne(User.class, "email", friendship.getEmailDest());
            if(friend != null)
                friendships.add(friend.toDTOWithLastPosition(UtilBusiness.getLastPosition(friend.getEmail())));
        }
        for(Friendship friendship : friendshipDAO.getAll(Friendship.class, "emailDest", user.getEmail())) {
            User friend = userDAO.getOne(User.class, "email", friendship.getEmailSource());
            if(friend != null)
                friendships.add(friend.toDTOWithLastPosition(UtilBusiness.getLastPosition(friend.getEmail())));
        }
        return friendships;
    }
}
