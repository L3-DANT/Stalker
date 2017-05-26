package com.dant.controller;

import com.dant.business.*;
import com.dant.dao.DAO;
import com.dant.entity.dto.*;
import com.dant.entity.*;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;

/**
 * Created by pitton on 2017-02-20.
 */
@Path("/api/user")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class UserController {
    private UserBusiness userBusiness = new UserBusiness();
    private MeetPointBusiness meetPointBusiness = new MeetPointBusiness();
    private FriendshipBusiness friendshipBusiness = new FriendshipBusiness();
    private PositionBusiness positionBusiness = new PositionBusiness();

    @POST
    public UserDTO authenticate(User u) {
        return userBusiness.authenticate(u);
    }

    @POST
    @Path("create")
    public UserDTO createUser(User user) {
        return userBusiness.createUser(user);
    }

    @PUT
    public UserDTO updateUser(User user) {
        return userBusiness.updateUser(user);
    }

    @DELETE
    public void removeUser(@HeaderParam("token") String token) {
        userBusiness.removeUser(token);
    }

    @POST
    @Path("createdataset")
    public String init () {
        DAO<User> userDAO = new DAO<>();
        DAO<Friendship> friendshipDAO= new DAO<>();
        DAO<MeetPoint> meetPointDAO = new DAO<>();
        DAO<Position> positionDAO = new DAO<>();
        System.out.println("Users : " +  userDAO.getAll(User.class));
        System.out.println("Friendships : " + friendshipDAO.getAll(Friendship.class));
        userBusiness.createUser(new User("Pierre", "pierre@gmail.com", "1234"));
        userBusiness.createUser(new User("Ondine", "ondine@gmail.com", "1234"));
        userBusiness.createUser(new User("Major Bob", "major.bob@gmail.com", "1234"));
        userBusiness.createUser(new User("Erika", "erika@gmail.com", "1234"));
        userBusiness.createUser(new User("Morgane", "morgane@gmail.com", "1234"));
        userBusiness.createUser(new User("Koga", "koga@gmail.com", "1234"));
        userBusiness.createUser(new User("Auguste", "auguste@gmail.com", "1234"));
        userBusiness.createUser(new User("Giovanni", "giovanni@gmail.com", "1234"));
        System.out.println("Users : " +  userDAO.getAll(User.class));

        friendshipBusiness.askFriend(new Friendship("giovanni@gmail.com", "koga@gmail.com"));
        friendshipBusiness.askFriend(new Friendship("giovanni@gmail.com", "major.bob@gmail.com"));

        friendshipBusiness.askFriend(new Friendship("erika@gmail.com", "pierre@gmail.com"));
        friendshipBusiness.askFriend(new Friendship("erika@gmail.com", "ondine@gmail.com"));
        friendshipBusiness.askFriend(new Friendship("erika@gmail.com", "major.bob@gmail.com"));
        friendshipBusiness.askFriend(new Friendship("erika@gmail.com", "morgane@gmail.com"));
        friendshipBusiness.askFriend(new Friendship("erika@gmail.com", "koga@gmail.com"));
        friendshipBusiness.askFriend(new Friendship("erika@gmail.com", "auguste@gmail.com"));
        friendshipBusiness.askFriend(new Friendship("erika@gmail.com", "giovanni@gmail.com"));
        friendshipBusiness.askFriend(new Friendship("pierre@gmail.com", "ondine@gmail.com"));

        friendshipBusiness.acceptFriend(new Friendship("erika@gmail.com", "pierre@gmail.com"));
        friendshipBusiness.acceptFriend(new Friendship("erika@gmail.com", "ondine@gmail.com"));
        friendshipBusiness.acceptFriend(new Friendship("erika@gmail.com", "major.bob@gmail.com"));
        friendshipBusiness.acceptFriend(new Friendship("erika@gmail.com", "morgane@gmail.com"));
        friendshipBusiness.acceptFriend(new Friendship("erika@gmail.com", "koga@gmail.com"));
        friendshipBusiness.acceptFriend(new Friendship("erika@gmail.com", "auguste@gmail.com"));
        friendshipBusiness.acceptFriend(new Friendship("erika@gmail.com", "giovanni@gmail.com"));
        friendshipBusiness.acceptFriend(new Friendship("pierre@gmail.com", "ondine@gmail.com"));
        System.out.println("Friendships : " + friendshipDAO.getAll(Friendship.class));

        meetPointBusiness.createMeetPoint(new MeetPoint("UPMC", "place Jussieu", "75005", "Paris", 48.846467, 2.354837, "pierre@gmail.com"));
        meetPointBusiness.createMeetPoint(new MeetPoint("Bar", "10 Rue Descartes", "75005", "Paris", 48.847095, 2.348675, "pierre@gmail.com"));

        meetPointBusiness.createMeetPoint(new MeetPoint("UPMC", "place Jussieu", "75005", "Paris", 48.846467, 2.354837, "ondine@gmail.com"));
        meetPointBusiness.createMeetPoint(new MeetPoint("Bar", "10 Rue Descartes", "75005", "Paris", 48.847095, 2.348675, "ondine@gmail.com"));
        System.out.println("MeetPoints: " + meetPointDAO.getAll(MeetPoint.class));

        System.out.println("Positions : " + positionDAO.getAll(Position.class));
        positionBusiness.createPosition(new Position(48.891808, 2.100231, 1495526400, "ondine@gmail.com"));
        positionBusiness.createPosition(new Position(48.898369, 2.094623, 1495527000, "ondine@gmail.com"));
        positionBusiness.createPosition(new Position(48.898299, 2.122228, 1495527150, "ondine@gmail.com"));
        positionBusiness.createPosition(new Position(48.890088, 2.134598, 1495527300, "ondine@gmail.com"));
        positionBusiness.createPosition(new Position(48.885221, 2.15567, 1495527450, "ondine@gmail.com"));
        positionBusiness.createPosition(new Position(48.887224, 2.171066, 1495527600, "ondine@gmail.com"));
        System.out.println("Positions : " + positionDAO.getAll(Position.class));
        return "Data Set ok";
    }
}
