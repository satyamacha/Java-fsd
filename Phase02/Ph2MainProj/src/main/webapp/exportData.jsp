<%@page import="java.util.Date"%>
<%@page import="com.opencsv.CSVWriter"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.tech.models.VitalModel"%>
<%@page import="java.util.Map"%>
<%@page import="com.tech.models.PatientModel"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.tech.dao.DB"%>
<%@page import="com.tech.models.AdminModel"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileWriter"%>
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
</style>
</head>
<body>
	<div
		style="display: flex; justify-content: space-between; align-items: center; width: 100%;">
		<h1>Doctor Home Page</h1>
		<a class="add-btn" href="AdminLoginController?mode=logout">Logout</a>
	</div>
	<%
	
	List<Map<String, Object>> vitalsInfo = new ArrayList<Map<String, Object>>();
	DB db = DB.getDb();
	String sqlQuery = "";
	if (request.getParameter("patientId") == null) {
		/* Exporting All Patient Vitals in csv */
		sqlQuery = "select v.*, p.name, p.phone, p.diagnosis from " + VitalModel.TABLE_NAME + " as v, "
		+ PatientModel.TABLE_NAME + " as p where v.patientId = p.patientId order by v.addedOn desc;";
	} else {
		/* Exporting Data for Particular Patient */
		sqlQuery = "select v.*, p.name, p.phone, p.diagnosis from " + VitalModel.TABLE_NAME + " as v, "
		+ PatientModel.TABLE_NAME + " as p where v.patientId = p.patientId and p.patientId="
		+ request.getParameter("patientId") + " order by v.addedOn desc;";
	}
	ResultSet result = db.executeQuery(sqlQuery);
	if (result.next()) {
		DateFormat format = DateFormat.getDateTimeInstance(DateFormat.SHORT, DateFormat.SHORT);
		Date date = new Date();
		
		String tempDir = System.getProperty("java.io.tmpdir");
		String filename = tempDir + "/myfile.csv";
		File file = new File(filename);
		CSVWriter writer = new CSVWriter(new FileWriter(file));
		writer.writeNext(new String[] { "Sr. No", "Name", "Phone", "BP Low", "BP High", "SPO2", "RecordedOn" });
		int idx = 0;
		while(result.next()) {
			writer.writeNext(new String[]{
					String.valueOf(++idx),
					result.getString("name"),
					result.getString("phone"),
					String.valueOf(result.getInt("bpLow")),
					String.valueOf(result.getInt("bpHigh")),
					String.valueOf(result.getInt("spo2")),
					format.format(result.getTimestamp("addedOn"))
			});
			
		}
		writer.flush();
		writer.close();
		out.println("<b>You are Successfully Created Csv file.</b></br>");
		out.println("<b>Downloaded at "+ filename +"</b>");
		
	} else {
		out.println("<b>Unable to created csv/xlsx file.</b>");
	}
	%>

</body>
</html>