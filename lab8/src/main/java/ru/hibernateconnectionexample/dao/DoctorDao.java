package ru.hibernateconnectionexample.dao;

import org.springframework.stereotype.Repository;
import ru.hibernateconnectionexample.domain.Type_Procedure;
import ru.hibernateconnectionexample.domain.Doctor;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@Repository
public class DoctorDao implements CrudDao<Doctor, Long> {

    private String databaseUrl = "jdbc:mysql://localhost:3306/polyclinic";

    private final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";

    private final String USER = "root";
    private final String PASSWORD = "1";

    @Override
    public void save(Doctor entity) {
    }

    @Override
    public void deleteById(Long aLong) {
    }

    @Override
    public void update(Long aLong, Doctor entity) {
    }

    @Override
    public Doctor findById(Long aLong) {
        return null;
    }

    @Override
    public Iterable<Doctor> findAll() {
        return executeFindAll("SELECT * FROM doctor");
    }

    private List<Doctor> executeFindAll(String query) {
        List<Doctor> doctors = new ArrayList<>();

        Connection conn = null;
        Statement statement = null;
        try {

            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(databaseUrl, USER, PASSWORD);
            statement = conn.createStatement();

            ResultSet resultSet = statement.executeQuery(query);

            while (resultSet.next()) {
                long id = resultSet.getLong(1);
                String firstName = resultSet.getString(2);
                String secondName= resultSet.getString(3);
                String patronymic = resultSet.getString(4);
                String phone = resultSet.getString(5);
                doctors.add(new Doctor(id, firstName, secondName, patronymic,phone));
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            if (statement != null) {
                try {
                    statement.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        return doctors;
    }
}
