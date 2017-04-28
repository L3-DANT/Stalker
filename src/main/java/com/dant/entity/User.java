package com.dant.entity;

import org.bson.types.ObjectId;
import org.mongodb.morphia.annotations.*;

import java.io.Serializable;

/**
 * Created by pitton on 2017-02-21.
 */
@Entity
public class User implements Serializable {

	@Id
	private ObjectId id;
	private String name;
	private String email;

	public User(String name, String email) {
		this.name = name;
		this.email = email;

	}

	public User() {
	}
	//blabla
	public ObjectId getId() { return id; }

	public String getName() { return name; }

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Override
	public boolean equals(Object o) {
		if (this == o) return true;
		if (o == null || getClass() != o.getClass()) return false;

		User account = (User) o;

		return email.equals(account.email);
	}

	@Override
	public int hashCode() {
		return email.hashCode();
	}

	@Override
	public String toString() {
		return email;
	}
}
