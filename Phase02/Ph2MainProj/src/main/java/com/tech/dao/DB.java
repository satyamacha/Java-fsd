package com.tech.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class DB {

	public final String DATABASE_NAME = "health_logger_db";
	Connection connection;
	Statement statement;

	private static DB db = new DB();

	public DB() {
		// TODO Auto-generated constructor stub
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			System.out.println("[DB] Driver Loaded");

			String url = "jdbc:mysql://localhost/" + DATABASE_NAME;
			String user = "root";
			String password = "Satti@2001";

			connection = DriverManager.getConnection(url, user, password);
			System.out.println("[DB] Connection Created");

			statement = connection.createStatement();
			System.out.println("[DB] Statement Created");

		} catch (Exception e) {
			System.out.println("Something Went Wrong: " + e);
		}
	}

	public static DB getDb() {
		return db;
	}

	public Connection getConnection() {
		return connection;
	}

	public int executeUpdate(String sql) {

		try {
			int result = 0;
			// executeUpdate -> for : insert update and delete instructions
			result = statement.executeUpdate(sql);
			System.out.println("[DB] SQL Statement Executed");
			return result;
		} catch (Exception e) {
			System.out.println("Something Went Wrong: " + e);
			return 0;
		}
	}

	public ResultSet executeQuery(String sql) {

//		ResultSet set = null; // data structure which will have data of table i.e. all the rows
		try {
			// executeUpdate -> for : query
			System.out.println(sql);
			System.out.println("[DB] SQL Statement Executed ");
			return statement.executeQuery(sql);

		} catch (Exception e) {
			System.out.println("Something Went Wrong: " + e);
			return null;
		}

	}

	public void closeConnection() {
		try {
			connection.close();
			System.out.println("[DB] Connection Closed");
		} catch (Exception e) {
			System.out.println("Something Went Wrong: " + e);
		}
	}
}
