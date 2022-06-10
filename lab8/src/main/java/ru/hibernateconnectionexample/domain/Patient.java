package ru.hibernateconnectionexample.domain;

import javax.persistence.*;

@Entity
@Table(name = "patient")
public class Patient {

    @Id
    @Column(name = "patient_id")
    private Long id;

    @Column(name = "patient_name")
    private String firstName;

    @Column(name = "patient_surname")
    private String secondName;

    @Column(name = "patient_patronymic")
    private String patronymic;

    @Column(name = "patient_phone")
    private String phone;

    @Column(name = "countprocedure")
    private Integer countprocedure;

    public Patient() {
    }

    public Patient(Long id, String firstName, String secondName, String patronymic, String phone, Integer countprocedure) {
        this.id = id;
        this.firstName = firstName;
        this.secondName = secondName;
        this.patronymic = patronymic;
        this.phone = phone;
        this.countprocedure=countprocedure;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getSecondName() {
        return secondName;
    }

    public void setSecondName(String secondName) {
        this.secondName = secondName;
    }

    public String getPatronymic() {
        return patronymic;
    }

    public void setPatronymic(String patronymic) {
        this.patronymic = patronymic;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

}
