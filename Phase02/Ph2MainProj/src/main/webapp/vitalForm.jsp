<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.models.PatientModel"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.tech.dao.DB"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Health Logger</title>
<style>
* {
	margin: 0;
	box-sizing: border-box;
}
body {
	height: 100vh;
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	/* gap: 12px; */
}
p {
	color: #a0a0a0;
	margin: 4px 0 24px 0;
}
form {
	display: flex;
	flex-direction: column;
	gap: 24px;
}
.form-group {
	display: flex;
	flex-direction: column;
	align-items: start;
	gap: 8px;
}
input:not([type="radio"]), textarea, select {
	width: 350px;
	padding: 10px;
	border: 1px solid #b9b9b9;
	border-radius: 8px;
}
input[type="radio"] {
	width: max-content;
}
button {
	width: 350px;
	border-radius: 12px;
	background: #32C732;
	color: #fff;
	font-weight: 700;
	padding: 10px 20px;
	border: none;
	cursor: pointer;
}
button:hover {
	background: #28A228;
}
</style>
</head>
<body>

	<%! 
		String mode; 
	%>
	<%
		mode = request.getParameter("mode");
		String patientVital = request.getParameter("isPatientVital");
		DB db = DB.getDb();
		List<PatientModel> patients = new ArrayList<PatientModel>();
		
		ResultSet result = db.executeQuery(PatientModel.getAllPatientQuery());
		while(result.next()) {
			patients.add(PatientModel.getPatientModel(result));
		}
	%>

	<h1>Health Logger</h1>
	<p>Add Patient's Vital Information</p>

	<form action="VitalController" method="post">
		<input type="text" name="mode" value="<%= mode %>" hidden="">
		<input type="text" name="isPatientVitals" value="<%= patientVital %>" hidden="">
		<div class="form-group">
			<label> Select Patient</label> 
			<select name="patientId" id="patientId">
				<% for(PatientModel patient: patients){ %>
					<option value="<%=patient.patientId %>"><%= patient.name %></option>
				<%}%>
			</select>
		</div>
		<div class="form-group">
			<label>BP Low</label> 
			<input type="number" name="bpLow" id="bpLow">
		</div>
		<div class="form-group">
			<label>BP High</label> 
			<input type="number" name="bpHigh" id="bpHigh">
		</div>
		<div class="form-group">
			<label>SPO2</label> 
			<input type="number" name="spo2" id="spo2" >
		</div>
		

		<div role="alert">
			<small>${message}</small>
		</div>
		<button type="submit">Submit</button>

	</form>

</body>
</html>