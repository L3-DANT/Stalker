package com.dant.business;

import com.dant.dao.DAO;
import com.dant.entity.Position;
import com.dant.entity.User;
import com.dant.entity.dto.PositionDTO;

import javax.ws.rs.BadRequestException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by 3502804 on 19/05/17.
 */
public class PositionBusiness {

    private final DAO<User> userDAO = new DAO<>();
    private final DAO<Position> positionDAO = new DAO<>();

    public PositionDTO createPosition(String token, double latitude, double longitude, long time) {
        User user = userDAO.getOne(User.class, "token", token);
        if(user == null)
            throw new BadRequestException();
        Position position = new Position(latitude, longitude, time);
        user.addPosition(position);
        userDAO.save(user);
        return positionDAO.save(position).toDTO();
    }

    public PositionDTO createPosition(String token, Position position) {
        User user = userDAO.getOne(User.class, "token", token);
        if(user == null)
            throw new BadRequestException();
        user.addPosition(position);
        userDAO.save(user);
        return positionDAO.save(position).toDTO();
    }

    public List<PositionDTO> getPositions(String token) {
        User user = userDAO.getOne(User.class, "token", token);
        List<PositionDTO> liste = new ArrayList<>();
        for(Position position : user.getPositions()) {
            liste.add(position.toDTO());
        }
        return liste;
    }
}
