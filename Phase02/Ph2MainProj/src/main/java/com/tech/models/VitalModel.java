package com.tech.models;

import java.util.Date;

public class VitalModel {

	public static final String TABLE_NAME = "vitals";

	public int vitalId;
	public int patientId;
	public int bpLow;
	public int bpHigh;
	public int spo2;
	public Date addedOn;

	public VitalModel() {
		// TODO Auto-generated constructor stub
	}

	public VitalModel(int vitalId, int patientId, int bpLow, int bpHigh, int spo2, Date addedOn) {
		super();
		this.vitalId = vitalId;
		this.patientId = patientId;
		this.bpLow = bpLow;
		this.bpHigh = bpHigh;
		this.spo2 = spo2;
		this.addedOn = addedOn;
	}

	@Override
	public String toString() {
		return "VitalModel [vitalId=" + vitalId + ", patientId=" + patientId + ", bpLow=" + bpLow + ", bpHigh=" + bpHigh
				+ ", spo2=" + spo2 + ", addedOn=" + addedOn + "]";
	}
	
	public String getInsertQuery() {
		return String.format("insert into %s (bpLow, bpHigh, spo2, patientId) values (%d, %d, %d, %d)", TABLE_NAME, bpLow, bpHigh, spo2, patientId);
	}

	// Getting All Latest Recorded Vital
	public static String getAllVitals() {
		return "select * from " + TABLE_NAME + "order by addedOn desc;";
	}

}