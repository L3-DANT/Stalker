package com.dant.dao;

import com.dant.util.MongoUtil;
import org.mongodb.morphia.Datastore;
import org.mongodb.morphia.query.Query;

import java.util.List;

/**
 * Created by 3502804 on 02/03/17.
 */
public class DAO<T> {

    private final Datastore ds = MongoUtil.ds();

    public T save(T object) {
        ds.save(object);
        return object;
    }

    public void delete(Class<T> clazz, String field, String value) {
        Query<T> query = ds.createQuery(clazz).filter(field, value);
        ds.delete(query);
    }

    public void delete(Class<T> clazz, String field1, String value1, String field2, String value2) {
        Query<T> query = ds.createQuery(clazz).field(field1).equal(value1).field(field2).equal(value2);
        ds.delete(query);
    }

    public T getOne(Class<T> clazz, String field, String value) {
        return ds.createQuery(clazz).filter(field, value).get();
    }

    public T getOne(Class<T> clazz,
                    String field1,
                    Object value1,
                    String field2,
                    Object value2) {
        return ds.createQuery(clazz)
                .field(field1).equal(value1)
                .field(field2).equal(value2).get();
    }

    public List<T> getAll(Class<T> clazz, String field, Object value) {
        return ds.createQuery(clazz).filter(field, value).asList();
    }

    public List<T> getAll(Class<T> clazz) {
//        System.out.println("Dans le getAll");
        Query<T> truc = ds.createQuery(clazz);
//        System.out.println("Nombre : ");
//        System.out.println("Qyery : " + ds.createQuery(clazz).count());
//        System.out.println("Nombre : " + truc.asList().toString());
        return truc.asList();
    }

}
