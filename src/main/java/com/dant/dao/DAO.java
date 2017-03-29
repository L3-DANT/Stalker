package com.dant.dao;

import com.dant.util.MongoUtil;
import org.mongodb.morphia.Datastore;

/**
 * Created by 3502804 on 02/03/17.
 */
public class DAO<T> {

    private final Datastore ds = MongoUtil.ds();

    public T save (T object) {
        ds.save(object);
        return object;
    }

    public T get(Class<T> clazz, String field, String value) {
        return ds.createQuery(clazz).filter(field, value).get();
    }

}
