<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Health Logger - Doctor Login</title>
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
	<%!String email, password;%>
	<%
	try {
		password = request.getParameter("password") == null ? "" : request.getParameter("password");
		email = request.getParameter("email") == null ? "" : request.getParameter("email");
	} catch (NullPointerException e) {
		password = "";
		email = "";
	}
	%>

	<h1>Health Logger</h1>
	<p>Doctor Login</p>

	<form action="AdminLoginController" method="post">
		<div class="form-group">
			<label>Enter Email</label> <input type="email" name="email"
				id="email" placeholder="abc@example.com" value="<%=email%>">
		</div>
		<div class="form-group">
			<label>Enter Password</label> <input type="password" name="password"
				id="password" placeholder="******" value="<%=password%>">
		</div>

		<div role="alert">
			<small>${message.message}</small>
		</div>

		<button type="submit">Login</button>

	</form>

</body>
</html>
