package ru.hibernateconnectionexample.dao;

public interface CrudDao<T, ID> {

    void save(T entity);

    void deleteById(ID id);

    void update(ID id, T entity);

    T findById(ID id);

    Iterable<T> findAll();
}
