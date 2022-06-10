package ru.hibernateconnectionexample.dao;

import org.springframework.stereotype.Repository;
import ru.hibernateconnectionexample.domain.Type_Procedure;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@Repository
public class Type_ProcedureDao implements CrudDao<Type_Procedure, Long> {

    private String databaseUrl = "jdbc:mysql://localhost:3306/polyclinic";

    private final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";

    private final String USER = "root";
    private final String PASSWORD = "1";

    @Override
    public Iterable<Type_Procedure> findAll() {
        return executeFindAll("SELECT * FROM type_procedure");
    }

    @Override
    public void save(Type_Procedure entity) {
    }

    @Override
    public void deleteById(Long id) {
    }

    @Override
    public void update(Long aLong, Type_Procedure entity) {
    }

    @Override
    public Type_Procedure findById(Long id) {
        return null;
    }

    private List<Type_Procedure> executeFindAll(String query) {
        List<Type_Procedure> Type_Procedures = new ArrayList<>();

        Connection conn = null;
        Statement statement = null;
        try {

            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(databaseUrl, USER, PASSWORD);
            statement = conn.createStatement();

            ResultSet resultSet = statement.executeQuery(query);

            while (resultSet.next()) {
                long id = resultSet.getLong(1);
                String name = resultSet.getString(2);
                String desc = resultSet.getString(3);
                int price = resultSet.getInt(4);

                Type_Procedures.add(new Type_Procedure(id, name, desc, price));
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

        return Type_Procedures;
    }
}
