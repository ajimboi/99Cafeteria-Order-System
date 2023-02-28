<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<title></title>
<link rel="stylesheet" href="style/profile.css" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
</head>
<body>
	<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	if (session.getAttribute("employee_id") == null) {
		response.sendRedirect("login.jsp");
	}
	%>
	<div class="button-back">
		<div class="button-back-item left-button">
			<a href="home.jsp"> <span class="material-symbols-outlined">
					arrow_back_ios </span></a>
		</div>
		<div class="button-back-item">
			<form action="logout" method="post">
				<button type="submit">
					<span class="material-symbols-outlined"> logout </span>
				</button>
			</form>
		</div>
	</div>
	<div class="profile-container">
		<div class="profile-container-item badge">
			<span class="material-symbols-outlined"> badge </span>
		</div>
		<div class="profile-container-item">
			<%
			String employee_credential = (String) session.getAttribute("employee_id");

			try {
				String url = "jdbc:mysql://localhost:3306/cafeteria";
				String username = "root";
				String password = "uplan";
				String sql = "SELECT * FROM `employee` WHERE EMPLOYEE_ID = " + employee_credential;

				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection connection = DriverManager.getConnection(url, username, password);
				Statement statement = connection.createStatement();

				ResultSet result = statement.executeQuery(sql);
				result.next();
			%>
			<h1>
				Name:
				<%=result.getString(2)%></h1>
			<h1>
				Username:
				<%=result.getString(1)%></h1>
			<div class="password-view">
				<div class="password-view-item">
					<h1 id="closed-password">
						<%
						int a = result.getString(3).length();
						while (a > 0) {
							out.println('*');
							a--;
						}
						%>
					</h1>
					<h1 id="open-password"><%=result.getString(3)%></h1>
				</div>
				<div class="password-view-item">
					<span class="material-symbols-outlined"> visibility </span>
				</div>
			</div>
			<%
			result.close();
			connection.close();
			} catch (Exception exception) {
			out.println(exception);
			}
			%>
		</div>
	</div>
	<script src="script/password_toggle.js"></script>
</body>
</html>

