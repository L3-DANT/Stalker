package com.dant.entity;

import org.bson.types.ObjectId;
import org.mongodb.morphia.annotations.*;

import java.io.Serializable;

/**
 * Created by pitton on 2017-02-21.
 */
@Entity
public class Account implements Serializable {

	@Id
	private ObjectId _id;
	private String email;
	private long updated;

	public Account() {
		updated = System.currentTimeMillis();
	}

	public Account(String email) {
		this();
		this.email = email;

	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public long getUpdated() {
		return updated;
	}

	public void setUpdated(long updated) {
		this.updated = updated;
	}

	@Override
	public boolean equals(Object o) {
		if (this == o) return true;
		if (o == null || getClass() != o.getClass()) return false;

		Account account = (Account) o;

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
