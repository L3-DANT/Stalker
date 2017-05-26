package com.dant.business;

import com.dant.dao.DAO;
import com.dant.entity.Position;
import com.dant.entity.User;
import com.dant.entity.dto.PositionDTO;

import javax.ws.rs.BadRequestException;
import javax.ws.rs.NotFoundException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by 3502804 on 19/05/17.
 */
public class PositionBusiness {

    private final DAO<User> userDAO = new DAO<>();
    private final DAO<Position> positionDAO = new DAO<>();

    public PositionDTO createPosition(Position position) {
        System.out.println("Position : " + position);
        if(userDAO.getOne(User.class, "email", position.getEmailUser()) == null)
            throw new NotFoundException();
        return positionDAO.save(position).toDTO();
    }

    public List<PositionDTO> getPositions(String emailUser) {
        if (userDAO.getOne(User.class, "email", emailUser) == null)
            throw new NotFoundException();

        List<PositionDTO> positions = new ArrayList<>();
        for(Position position : positionDAO.getAll(Position.class, "emailUser", emailUser)) {
            positions.add(position.toDTO());
        }
        return positions;
    }

    public PositionDTO getLastPosition(String emailUser) {
        if (userDAO.getOne(User.class, "email", emailUser) == null)
            throw new NotFoundException();
        Position last = positionDAO.getOne(Position.class,"emailUser", emailUser);
        for(Position position : positionDAO.getAll(Position.class,"emailUser", emailUser)) {

        }
        return null;
    }
}
