package ru.hibernateconnectionexample.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import ru.hibernateconnectionexample.domain.Patient;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import java.util.List;

@Repository
public class PatientDao implements CrudDao <Patient, Long> {

    private final EntityManagerFactory emf;

    @Autowired
    public PatientDao(EntityManagerFactory emf) {
        this.emf = emf;
    }

    @Override
    public void save(Patient entity) {
    }

    @Override
    public void deleteById(Long aLong) {
    }

    @Override
    public void update(Long aLong, Patient entity) {
    }

    @Override
    public Patient findById(Long aLong) {
        return null;
    }

    @Override
    public Iterable<Patient> findAll() {
        EntityManager entityManager = emf.createEntityManager();

        entityManager.getTransaction().begin();

        List patients = entityManager.createQuery("SELECT p FROM Patient p").getResultList();
        entityManager.getTransaction().commit();

        return patients;
    }
}
