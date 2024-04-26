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
input:not([type="radio"]), textarea {
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
		DB db = DB.getDb();
		PatientModel model = new PatientModel(0, "", "", "", 0, "", "", "", 0, null); 
		String mode; 
	%>
	<%
		mode = request.getParameter("mode");
		if(mode.equals("update")) {
			String patientId = request.getParameter("patientId");
			ResultSet result = db.executeQuery(PatientModel.getPatientByIdQuery(patientId));
			if(result.next()) {
				model = PatientModel.getPatientModel(result);
			}
		}
	%>
	
	<br>
	<br>

	<h1>Health Logger</h1>
	<p>Add/Update Patient Information</p>

	<form action="PatientController" method="post">
		<input type="text" name="mode" value="<%= mode %>" hidden="">
		<input type="text" name="patientId" value="<%= model.patientId %>" hidden="">
		<div class="form-group">
			<label> Name</label> 
			<input type="text" name="name" id="name" placeholder="John Peterson" value="<%=model.name %>">
		</div>
		<div class="form-group">
			<label>Email</label> 
			<input type="email" name="email" id="email" placeholder="abc@example.com" value="<%=model.email %>">
		</div>
		<div class="form-group">
			<label>Phone</label> 
			<input type="text" name="phone" id="phone" placeholder="+91 ***** *****" value="<%=model.phone %>">
		</div>
		<div class="form-group">
			<label>Age</label> 
			<input type="number" name="age" id="age" placeholder="eg: 22" value="<%=model.age %>">
		</div>
		<div class="form-group">
			<label>Diagnosis</label> 
			<input type="text" name="diagnosis" id="diagnosis" placeholder="eg: Blood Pressure" value="<%=model.diagnosis %>">
		</div>
		<div class="form-group">
			<label>Remark</label> 
			<textarea rows="5" name="remarks" id="remarks"><%=model.remarks %></textarea>
		</div>
		
		<div class="form-group">
			<span>Gender</span>
			<div style="display: flex; gap: 12px;">
				<input type="radio" name="gender" id="male" value="male"> 
				<label for="male">Male</label>
			</div>
			<div style="display: flex; gap: 12px;">
				<input type="radio" name="gender" id="female" value="female"> 
				<label for="female">Female</label>
			</div>
		</div>

		<div role="alert">
			<small>${message}</small>
		</div>
		<button type="submit">Sumbit</button>

	</form>

</body>
</html>