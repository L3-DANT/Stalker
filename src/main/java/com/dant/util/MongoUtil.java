package com.dant.util;

import com.dant.entity.Account;
import com.mongodb.MongoClient;
import org.mongodb.morphia.Datastore;
import org.mongodb.morphia.Morphia;

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
            set.add(Account.class);
            return new Morphia(set).createDatastore(client, "kevin");
        }

    }

    private MongoUtil() {}
}
