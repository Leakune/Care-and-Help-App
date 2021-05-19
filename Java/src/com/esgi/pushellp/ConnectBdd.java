package com.esgi.pushellp;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectBdd {
    private String jdbcURL;
    private String username;
    private String password;
    private Connection connection;

    public ConnectBdd() {
        jdbcURL = "jdbc:postgresql://localhost/pushellp";
        username = "postgres";
        password = "root";

    }

    public Connection getConnection() throws SQLException, ClassNotFoundException {
        //Class.forName("org.postgresql.Driver");
        connection = DriverManager.getConnection(jdbcURL, username, password);

        return connection;
    }
}
