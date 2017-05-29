package com.dant.util;

import com.dant.entity.*;
import com.mongodb.MongoClient;
import org.mongodb.morphia.Datastore;
import org.mongodb.morphia.Morphia;

import java.math.BigInteger;
import java.security.SecureRandom;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by 3502804 on 02/03/17.
 */
public class MongoUtil {

    public static Datastore ds() {
        return Init.ds;
    }

    private static final class Init {

        private static final Datastore ds = getDatastore();

        private static Datastore getDatastore() {
            MongoClient client = new MongoClient();

            Set<Class> set = new HashSet<>(1);
            set.add(User.class);
            set.add(Position.class);
            set.add(MeetPoint.class);
            set.add(Friendship.class);
            return new Morphia(set).createDatastore(client, "StalkerDb");
        }

    }

    private MongoUtil() {}

    public static String generateToken() {
        return new BigInteger(130, new SecureRandom()).toString(32);
    }

}
