<%@page import="com.google.gson.Gson"%>
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
	<%!
	Map<String, Object> getMapObject(String xValue, int yValue) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("label", xValue);
		map.put("y", yValue);
		return map;
	}
	%>

	<%
	
	Gson gsonObj = new Gson();
	List<Map<String, Object>> vitalsInfo = new ArrayList<Map<String, Object>>();
	DB db = DB.getDb();
	boolean isPatientVitals = false;
	String sqlQuery = "";
	if (request.getParameter("patientId") == null) {
		/* Exporting All Patient Vitals in csv */
		isPatientVitals = false;
		sqlQuery = "select v.*, p.name, p.phone, p.diagnosis from " + VitalModel.TABLE_NAME + " as v, "
		+ PatientModel.TABLE_NAME + " as p where v.patientId = p.patientId order by v.addedOn desc;";
	} else {
		/* Exporting Data for Particular Patient */
		isPatientVitals = true;
		sqlQuery = "select v.*, p.name, p.phone, p.diagnosis from " + VitalModel.TABLE_NAME + " as v, "
		+ PatientModel.TABLE_NAME + " as p where v.patientId = p.patientId and p.patientId="
		+ request.getParameter("patientId") + ";";
	}
	ResultSet result = db.executeQuery(sqlQuery);
	List<Map<String, Object>> bpLowList = new ArrayList<Map<String, Object>>();
	List<Map<String, Object>> bpHighList = new ArrayList<Map<String, Object>>();
	List<Map<String, Object>> spo2List = new ArrayList<Map<String, Object>>();
	int index = 0;
	while (result.next()) {
		DateFormat format = DateFormat.getDateTimeInstance(DateFormat.SHORT, DateFormat.SHORT);
		Map<String, Object> vitalMap = new HashMap<String, Object>();
		vitalMap.put("vitalId", result.getInt("vitalId"));
		vitalMap.put("patientId", result.getInt("patientId"));
		vitalMap.put("bpLow", result.getInt("bpLow"));
		vitalMap.put("bpHigh", result.getInt("bpHigh"));
		vitalMap.put("spo2", result.getInt("spo2"));
		vitalMap.put("name", result.getString("name"));
		vitalMap.put("phone", result.getString("phone"));
		vitalMap.put("addedOn", format.format(result.getTimestamp("addedOn")));
		
		bpLowList.add(getMapObject(format.format(result.getTimestamp("addedOn")), result.getInt("bpLow")));
		bpHighList.add(getMapObject(format.format(result.getTimestamp("addedOn")), result.getInt("bpHigh")));
		spo2List.add(getMapObject(format.format(result.getTimestamp("addedOn")), result.getInt("spo2")));
		index += 1;
		vitalsInfo.add(vitalMap);
	}
	%>
	<div
		style="display: flex; justify-content: space-between; align-items: center; width: 100%;">
		<h1>Doctor Home Page</h1>
		<a class="add-btn" href="AdminLoginController?mode=logout">Logout</a>
	</div>
	<div
		style="display: flex; justify-content: space-between; align-items: center; width: 100%; margin: 8px 0;">
		<h3>Vitals</h3>
		<div
			style="display: flex; justify-content: end; align-items: center; gap: 12px;">
				<a class="add-btn" href="managePatients.jsp">Manage Patients</a>
				<a class="add-btn" href="exportData.jsp">Export</a> 
				<a class="add-btn" href="vitalForm.jsp?mode=add&isPatientVital=<%=isPatientVitals%>">Record New Vital</a>
				<a class="add-btn" href="vitalAlerts.jsp">Vital Alerts</a>
		</div>
	</div>
	
	<%if (isPatientVitals) {%>
	<div id="chartContainer" style="height: 370px; width: 100%; margin: 4px 0;"></div>
	<%}%>
	<div style="overflow-x: auto;">
		<table>
			<thead>
				<tr>
					<th>Sr. No</th>
					<th>Name</th>
					<th>Phone</th>
					<th>BP Low</th>
					<th>BP High</th>
					<th>SPO2</th>
					<th>Recorded On</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
				<%
				for (int idx = 0; idx < vitalsInfo.size(); idx++) {
					Map<String, Object> vital = vitalsInfo.get(idx);
				%>
				<tr>
					<td><%=idx + 1%></td>
					<td><%=vital.get("name")%></td>
					<td><%=vital.get("phone")%></td>
					<td><%=vital.get("bpLow")%></td>
					<td><%=vital.get("bpHigh")%></td>
					<td><%=vital.get("spo2")%></td>
					<td><%=vital.get("addedOn")%></td>
					<td><a
						href="<%=request.getContextPath()%>/VitalController?mode=delete&vitalId=<%=vital.get("vitalId")%>">Delete</a>
					</td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</div>
	<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
	<script type="text/javascript">
		
	<%if (isPatientVitals) {%>
		window.onload = function() {
			var chart = new CanvasJS.Chart("chartContainer", {
				animationEnabled: true,
				zoomEnabled: true,
				theme: "light2",
				title: {
					text: "Patient's Vitals"
				},
				axisX: {
					title: "Recorded On",
					valueFormatString: "dd/MM/yyyy hh:mm:ss a"
				},
				axisY: {
					logarithmic: true, //change it to false
					title: "Vitals",
					titleFontColor: "#6D78AD",
					lineColor: "#6D78AD",
					gridThickness: 0,
					lineThickness: 1,
				},
				toolTip: {
					shared: true
				},
				legend: {
					verticalAlign: "top",
					dockInsidePlotArea: true
				},
				data: [{
					type: "line",
					showInLegend: true,
					name: "BP Low",
					legendText: "{name}",
					dataPoints: <%out.print(gsonObj.toJson(bpLowList));%>
				},
				{
					type: "line",
					showInLegend: true,
					name: "BP High",
					legendText: "{name}",
					dataPoints: <%out.print(gsonObj.toJson(bpHighList));%>
				},
				{
					type: "line",
					showInLegend: true,
					name: "SPO2",
					legendText: "{name}",
					dataPoints: <%out.print(gsonObj.toJson(spo2List));%>
				}]
			});
			chart.render();
		}
	<%}%>
		
	</script>
</body>
</html>