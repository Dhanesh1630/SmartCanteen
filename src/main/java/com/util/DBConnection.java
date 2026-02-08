package com.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    private static Connection con = null;

    private DBConnection() {
    }

    public static Connection getConnection() {

        try {
            if (con == null) {

                Class.forName("com.mysql.cj.jdbc.Driver");

                con = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/smartcanteendb",
                        "root",
                        "Dhanesh123@#"
                );

                System.out.println("Database Connected Successfully!");
                System.out.println("DB Connected: " + con);

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return con;
    }
}
