package com.dant.app;

import com.dant.controller.*;
import com.dant.business.*;
import com.dant.entity.User;
import com.dant.entity.dto.UserDTO;
import com.dant.exception.BadRequestExceptionMapper;
import com.dant.exception.ForbiddenExceptionMapper;
import com.dant.exception.NotFoundExceptionMapper;
import com.dant.exception.RuntimeExceptionMapper;
import com.dant.filter.GsonProvider;

import javax.ws.rs.ApplicationPath;
import javax.ws.rs.core.Application;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by pitton on 2017-02-20.
 */
@ApplicationPath("")
public class App extends Application {

	@Override
	public Set<Object> getSingletons() {
		Set<Object> sets = new HashSet<>();
		sets.add(new UserController());
		sets.add(new MeetPointController());
		sets.add(new FriendshipController());
		sets.add(new PositionController());
		return sets;
	}

	@Override
	public Set<Class<?>> getClasses() {
		Set<Class<?>> sets = new HashSet<>();
		sets.add(GsonProvider.class);
		sets.add(RuntimeExceptionMapper.class);
		sets.add(ForbiddenExceptionMapper.class);
		sets.add(NotFoundExceptionMapper.class);
		sets.add(BadRequestExceptionMapper.class);
		return sets;
	}

	public static void main(String[] args) {
		UserBusiness userBusiness = new UserBusiness();
		MeetPointBusiness meetPointBusiness = new MeetPointBusiness();
		FriendshipBusiness friendshipBusiness = new FriendshipBusiness();
		PositionBusiness positionBusiness = new PositionBusiness();

		userBusiness.createUser(new User("Pierre", "pierre@gmail.com", "1234"));
		userBusiness.createUser(new User("Ondine", "ondine@gmail.com", "1234"));
		userBusiness.createUser(new User("Major Bob", "major.bob@gmail.com", "1234"));
		userBusiness.createUser(new User("Erika", "erika@gmail.com", "1234"));
		userBusiness.createUser(new User("Morgane", "morgane@gmail.com", "1234"));
		userBusiness.createUser(new User("Koga", "koga@gmail.com", "1234"));
		userBusiness.createUser(new User("Auguste", "auguste@gmail.com", "1234"));
		userBusiness.createUser(new User("Giovanni", "giovanni@gmail.com", "1234"));

		friendshipBusiness.askFriend("giovanni@gmail.com", "koga@gmail.com");
		friendshipBusiness.askFriend("giovanni@gmail.com", "major.bob@gmail.com");

		friendshipBusiness.askFriend("erika@gmail.com", "pierre@gmail.com");
		friendshipBusiness.askFriend("erika@gmail.com", "ondine@gmail.com");
		friendshipBusiness.askFriend("erika@gmail.com", "major.bob@gmail.com");
		friendshipBusiness.askFriend("erika@gmail.com", "morgane@gmail.com");
		friendshipBusiness.askFriend("erika@gmail.com", "koga@gmail.com");
		friendshipBusiness.askFriend("erika@gmail.com", "auguste@gmail.com");
		friendshipBusiness.askFriend("erika@gmail.com", "giovanni@gmail.com");
		friendshipBusiness.askFriend("pierre@gmail.com", "ondine@gmail.com");

		friendshipBusiness.acceptFriend("erika@gmail.com", "pierre@gmail.com");
		friendshipBusiness.acceptFriend("erika@gmail.com", "ondine@gmail.com");
		friendshipBusiness.acceptFriend("erika@gmail.com", "major.bob@gmail.com");
		friendshipBusiness.acceptFriend("erika@gmail.com", "morgane@gmail.com");
		friendshipBusiness.acceptFriend("erika@gmail.com", "koga@gmail.com");
		friendshipBusiness.acceptFriend("erika@gmail.com", "auguste@gmail.com");
		friendshipBusiness.acceptFriend("erika@gmail.com", "giovanni@gmail.com");
		friendshipBusiness.acceptFriend("pierre@gmail.com", "ondine@gmail.com");

		UserDTO user = userBusiness.authenticate("ondine@gmail.com", "1234");
		meetPointBusiness.createMeetPoint(user.token, "UPMC", "place Jussieu", 75005, "Paris", 48.846467, 2.354837);
		meetPointBusiness.createMeetPoint(user.token, "Bar", "10 Rue Descartes", 75005, "Paris", 48.847095, 2.348675);

		user = userBusiness.authenticate("pierre@gmail.com", "1234");
		meetPointBusiness.createMeetPoint(user.token, "UPMC", "place Jussieu", 75005, "Paris", 48.846467, 2.354837);
		meetPointBusiness.createMeetPoint(user.token, "Bar", "10 Rue Descartes", 75005, "Paris", 48.847095, 2.348675);
		positionBusiness.createPosition(user.token, 48.891808, 2.100231, 1495526400);
		positionBusiness.createPosition(user.token, 48.898369, 2.094623, 1495527000);
		positionBusiness.createPosition(user.token, 48.898299, 2.122228, 1495527150);
		positionBusiness.createPosition(user.token, 48.890088, 2.134598, 1495527300);
		positionBusiness.createPosition(user.token, 48.885221, 2.15567, 1495527450);
		positionBusiness.createPosition(user.token, 48.887224, 2.171066, 1495527600);












	}
}