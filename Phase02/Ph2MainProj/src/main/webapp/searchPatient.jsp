<%@page import="com.tech.models.PatientModel"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.tech.dao.DB"%>
<%@page import="com.tech.models.AdminModel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Health Logger</title>
<style>
table {
	width: 100%;
	border-collapse: collapse;
	/* border: 1px solid #a0a0a0; */
}
th, td {
	text-align: left;
	padding: 12px;
	border-bottom: 1px solid #a0a0a0;
}
td a, .add-btn {
	text-decoration: none;
	padding: 4px 16px;
	color: #000;
	background-color: #d9d9d9;
	border-radius: 8px;
	margin: 12px 0;
}
h3 {
	margin: 0;
}
form {
	display: flex;
	flex-direction: column;
	gap: 24px;
}
.form-group {
	display: flex;
	flex-direction: column;
	gap: 8px;
}
input {
	width: 350px;
	padding: 10px 20px;
	border: 1px solid #eee;
	border-radius: 12px;
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

	<div
		style="display: flex; justify-content: space-between; align-items: center; width: 100%;">
		<h1>Doctor Home Page</h1>
		<a class="add-btn" href="AdminLoginController?mode=logout">Logout</a>
	</div>

		<div
			style="display: flex; align-items: center; width: 100%; margin: 8px 0; gap: 12px;">
			<a class="add-btn" href="managePatients.jsp">Home</a> 
			<a class="add-btn" href="patientForm.jsp?mode=add">Add Patient</a>
		</div>

	<div>
		<form action='searchPatient.jsp' method="post">
			<div class="form-group">
				<label>Search Patient</label> 
				<input type="text" name="search"id="search" placeholder="Search By Name..">
				<input type="submit" value="Search">
			</div>
		</form>
		<br>
	</div>

	<%
	
	String searchText = request.getParameter("search");
	if(searchText == null){
		return;
	}
	
	List<PatientModel> patients = new ArrayList<PatientModel>();
	DB db = DB.getDb();
	
	ResultSet result = db.executeQuery("select * from patients where name like '"+searchText+"%';");
	while (result.next()) {
		patients.add(PatientModel.getPatientModel(result));
	}
	%>
	<div
		style="display: flex; justify-content: space-between; align-items: center; width: 100%; margin: 8px 0;">
		<h3>
			Patient (<%=patients.size()%>)
		</h3>
	</div>
	
	<div style="overflow-x: auto;">
		<table>
			<thead>
				<tr>
					<th>Sr. No</th>
					<th>Name - Age</th>
					<th>Email</th>
					<th>Phone</th>
					<th>Diagnosis</th>
					<th>Remark</th>
					<th>gender</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
				<%
				for (int idx = 0; idx < patients.size(); idx++) {
					PatientModel patient = patients.get(idx);
				%>
				<tr>
					<td><%=idx + 1%></td>
					<td><%=patient.name%> - <%=patient.age%></td>
					<td><%=patient.email%></td>
					<td><%=patient.phone%></td>
					<td><%=patient.diagnosis%></td>
					<td><%=patient.remarks%></td>
					<td><%=patient.gender%></td>
					<td>
						<a href="manageVitals.jsp?patientId=<%=patient.patientId%>">Manage Vitals</a>
						<a href="patientForm.jsp?mode=update&patientId=<%=patient.patientId%>">Update</a>
						<a href="<%=request.getContextPath()%>/PatientController?mode=delete&patientId=<%=patient.patientId%>">Delete</a>
					</td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</div>
</body>
</html>