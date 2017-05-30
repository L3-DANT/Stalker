package com.dant.business;

import com.dant.dao.DAO;
import com.dant.entity.Position;
import com.dant.entity.User;
import com.dant.entity.dto.PositionDTO;

import javax.ws.rs.ForbiddenException;
import javax.ws.rs.NotFoundException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by 3502804 on 19/05/17.
 */
public class PositionBusiness {

    private final DAO<User> userDAO = new DAO<>();
    private final DAO<Position> positionDAO = new DAO<>();

    public PositionDTO createPosition(String token, Position position) {
        User user = UtilBusiness.checkToken(token);
        if(!user.getEmail().equals(position.getEmailUser()))
            throw new ForbiddenException();
        return positionDAO.save(position).toDTO();
    }

    public List<PositionDTO> getPositions(String token, String emailUser) {
        UtilBusiness.checkToken(token);
        List<PositionDTO> positions = new ArrayList<>();
        for(Position position : positionDAO.getAll(Position.class, "emailUser", emailUser)) {
            positions.add(position.toDTO());
        }
        return positions;
    }

    public PositionDTO getLastPosition(String token, String emailUser) {
        UtilBusiness.checkToken(token);
        if (userDAO.getOne(User.class, "email", emailUser) == null)
            throw new NotFoundException();
        Position last = UtilBusiness.getLastPosition(emailUser);
        if(last == null)
            return null;
        return last.toDTO();
    }
}
