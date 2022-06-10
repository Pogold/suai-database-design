package ru.jdbcconnectionexample;

import net.proteanit.sql.DbUtils;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.sql.*;

public class JdbcMain {

    public static void main(String[] args) throws SQLException {

        String url = "jdbc:mysql://localhost:3306/polyclinic";
        String user = "root";
        String password = "1";

        Connection con = DriverManager.getConnection(url, user, password);

        String query = "SELECT * FROM type_procedure";

        Statement stm = con.createStatement();
        ResultSet res = stm.executeQuery(query);

        JTable table = new JTable();
        table.setModel(DbUtils.resultSetToTableModel(res));
        table.setShowGrid(true);
        table.setShowVerticalLines(true);
        JScrollPane pane = new JScrollPane(table);
        JFrame f = new JFrame("JDBC");
        JPanel panel = new JPanel();
        panel.add(pane);
        f.add(panel);
        f.setSize(500, 250);
        f.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        f.setVisible(true);

        stm.close();
        res.close();
        con.close();
    }
}
