package com.flight.flight;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    // Database credentials for XAMPP
    private static final String URL = "jdbc:mysql://localhost:3306/irene_airways";
    private static final String USER = "root";
    private static final String PASS = ""; // XAMPP default is empty string

    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        // Registers the MySQL Driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, USER, PASS);
    }
}