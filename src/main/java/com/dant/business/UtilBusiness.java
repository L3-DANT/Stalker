package com.dant.business;

import com.dant.dao.DAO;
import com.dant.entity.Friendship;
import com.dant.entity.MeetPoint;
import com.dant.entity.Position;
import com.dant.entity.User;

import javax.ws.rs.ForbiddenException;

/**
 * Created by 3502804 on 29/05/17.
 */
public class UtilBusiness {
    private final static DAO<User> userDAO = new DAO<>();
    private final static DAO<Friendship> friendshipDAO= new DAO<>();
    private final static DAO<MeetPoint> meetPointDAO = new DAO<>();
    private final static DAO<Position> positionDAO = new DAO<>();

    public static User checkToken(String token) {
        User user = userDAO.getOne(User.class, "token", token);
        if(user == null)
            throw new ForbiddenException();
        return user;
    }

    public static Position getLastPosition(String emailUser) {
        Position last = positionDAO.getOne(Position.class,"emailUser", emailUser);
        for(Position position : positionDAO.getAll(Position.class,"emailUser", emailUser)) {
            if(position.getTime() > last.getTime())
                last = position;
        }
        return last;
    }

    public static String createDataSet() {
        userDAO.save(new User("Pierre", "pierre@gmail.com", "1234"));
        userDAO.save(new User("Ondine", "ondine@gmail.com", "1234"));
        userDAO.save(new User("Major Bob", "major.bob@gmail.com", "1234"));
        userDAO.save(new User("Erika", "erika@gmail.com", "1234"));
        userDAO.save(new User("Morgane", "morgane@gmail.com", "1234"));
        userDAO.save(new User("Koga", "koga@gmail.com", "1234"));
        userDAO.save(new User("Auguste", "auguste@gmail.com", "1234"));
        userDAO.save(new User("Giovanni", "giovanni@gmail.com", "1234"));
        System.out.println("Users : " +  userDAO.getAll(User.class));

        friendshipDAO.save(new Friendship("giovanni@gmail.com", "koga@gmail.com"));
        friendshipDAO.save(new Friendship("giovanni@gmail.com", "major.bob@gmail.com"));

        friendshipDAO.save(new Friendship("erika@gmail.com", "pierre@gmail.com", true));
        friendshipDAO.save(new Friendship("erika@gmail.com", "ondine@gmail.com", true));
        friendshipDAO.save(new Friendship("erika@gmail.com", "major.bob@gmail.com", true));
        friendshipDAO.save(new Friendship("erika@gmail.com", "morgane@gmail.com", true));
        friendshipDAO.save(new Friendship("erika@gmail.com", "koga@gmail.com", true));
        friendshipDAO.save(new Friendship("erika@gmail.com", "auguste@gmail.com", true));
        friendshipDAO.save(new Friendship("erika@gmail.com", "giovanni@gmail.com", true));
        friendshipDAO.save(new Friendship("pierre@gmail.com", "ondine@gmail.com", true));
        System.out.println("Friendships : " + friendshipDAO.getAll(Friendship.class));

        meetPointDAO.save(new MeetPoint("UPMC", "place Jussieu", 75005, "Paris", 48.846467, 2.354837, "pierre@gmail.com"));
        meetPointDAO.save(new MeetPoint("Bar", "10 Rue Descartes", 75005, "Paris", 48.847095, 2.348675, "pierre@gmail.com"));

        meetPointDAO.save(new MeetPoint("UPMC", "place Jussieu", 75005, "Paris", 48.846467, 2.354837, "ondine@gmail.com"));
        meetPointDAO.save(new MeetPoint("Bar", "10 Rue Descartes", 75005, "Paris", 48.847095, 2.348675, "ondine@gmail.com"));
        System.out.println("MeetPoints: " + meetPointDAO.getAll(MeetPoint.class));

        positionDAO.save(new Position(48.891808, 2.100231, 1495526400, "ondine@gmail.com"));
        positionDAO.save(new Position(48.898369, 2.094623, 1495527000, "ondine@gmail.com"));
        positionDAO.save(new Position(48.898299, 2.122228, 1495527150, "ondine@gmail.com"));
        positionDAO.save(new Position(48.890088, 2.134598, 1495527300, "ondine@gmail.com"));
        positionDAO.save(new Position(48.885221, 2.15567, 1495527450, "ondine@gmail.com"));
        positionDAO.save(new Position(48.887224, 2.171066, 1495527600, "ondine@gmail.com"));
        positionDAO.save(new Position(48.892092, 2.237349, 1495528200, "ondine@gmail.com"));
        positionDAO.save(new Position(48.858701, 2.347298, 1495528800, "ondine@gmail.com"));
        positionDAO.save(new Position(48.845994, 2.354808, 1495530000, "ondine@gmail.com"));
        System.out.println("Positions : " + positionDAO.getAll(Position.class));
        return "Data Set ok";
    }
}
