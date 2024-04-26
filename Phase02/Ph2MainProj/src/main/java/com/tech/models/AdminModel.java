package com.tech.models;

import java.sql.ResultSet;

import java.sql.SQLException;
import java.util.Date;

public class AdminModel {
	
	public final String TABLE_NAME = "admins";

	public int adminId;
	public String name;
	public String email;
	public String password;
	public Date registeredOn;
	
	public AdminModel() {
		// TODO Auto-generated constructor stub
	}


	public AdminModel(int adminId, String name, String email, String password, Date registeredOn) {
		this.adminId = adminId;
		this.name = name;
		this.email = email;
		this.password = password;
		this.registeredOn = registeredOn;
	}
	
	public AdminModel getAdminModel(ResultSet resultSet) throws SQLException {
		AdminModel admin = new AdminModel();
		admin.adminId = resultSet.getInt("adminId");
		admin.name = resultSet.getString("name");
		admin.email = resultSet.getString("email");
		admin.password = resultSet.getString("password");
		admin.registeredOn = resultSet.getDate("registeredOn");
		return admin;
	}


	@Override
	public String toString() {
		return "AdminModel [adminId=" + adminId + ", name=" + name + ", email=" + email + ", password=" + password
				+ ", registeredOn=" + registeredOn + "]";
	}
	
	public String toAdminLoginSql() {
		return "select * from "+ TABLE_NAME +" where email='"+ email +"' and password='" + password + "';";
	}
	
}
