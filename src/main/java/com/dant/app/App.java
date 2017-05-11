package com.dant.app;

import com.dant.controller.MeetPointController;
import com.dant.controller.UserController;
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
}
