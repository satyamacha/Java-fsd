package com.tech.models;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

public class PatientModel {

	public static final String TABLE_NAME = "patients";

	public int patientId;
	public String name;
	public String email;
	public String phone;
	public int age;
	public String diagnosis;
	public String remarks;
	public String gender;
	public int createdByAdminId;
	public Date registeredOn;

	public PatientModel() {
		// TODO Auto-generated constructor stub
	}

	public PatientModel(int patientId, String name, String email, String phone, int age, String diagnosis,
			String remarks, String gender, int createdByAdminId, Date registeredOn) {
		this.patientId = patientId;
		this.name = name;
		this.email = email;
		this.phone = phone;
		this.age = age;
		this.diagnosis = diagnosis;
		this.remarks = remarks;
		this.gender = gender;
		this.createdByAdminId = createdByAdminId;
		this.registeredOn = registeredOn;
	}

	public static PatientModel getPatientModel(ResultSet result) throws SQLException {
		PatientModel model = new PatientModel();
		model.patientId = result.getInt("patientId");
		model.name = result.getString("name");
		model.email = result.getString("email");
		model.phone = result.getString("phone");
		model.age = result.getInt("age");
		model.diagnosis = result.getString("diagnosis");
		model.remarks = result.getString("remarks");
		model.gender = result.getString("gender");
		model.createdByAdminId = result.getInt("createdByAdminId");
		model.registeredOn = result.getDate("registeredOn");
		return model;
	}

	@Override
	public String toString() {
		return "PatientModel [TABLE_NAME=" + TABLE_NAME + ", patientId=" + patientId + ", name=" + name + ", email="
				+ email + ", phone=" + phone + ", age=" + age + ", diagnosis=" + diagnosis + ", remarks=" + remarks
				+ ", gender=" + gender + ", createdByAdminId=" + createdByAdminId + ", registeredOn=" + registeredOn
				+ "]";
	}

	public String getPatientInsertQuery() {
		return "insert into " + TABLE_NAME
				+ " (name, email, phone, age, diagnosis, remarks, gender, createdByAdminId) values ('" + name + "', '"
				+ email + "', '" + phone + "', " + age + ", '" + diagnosis + "', '" + remarks + "', '" + gender + "', "
				+ createdByAdminId + ");";
	}

	public String getUpdateQuery() {
		return "update " + TABLE_NAME + " set name='" + name + "', email='" + email + "', phone='" + phone
				+ "', diagnosis='" + diagnosis + "', remarks='" + remarks + "', gender='" + gender + "', age=" + age
				+ " where patientId=" + patientId + ";";
	}
	
	public static String getDeleteQuery(int patientId) {
		return "delete from " + TABLE_NAME + " where patientId= "+ patientId + ";";
	}

	public static String getAllPatientQuery() {
		return "select * from " + TABLE_NAME + ";";
	}

	public static String getPatientByIdQuery(String patientId) {
		return "select * from " + TABLE_NAME + ";";
	}

}
