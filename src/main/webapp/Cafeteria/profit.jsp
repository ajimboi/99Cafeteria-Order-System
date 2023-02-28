<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title></title>
<link rel="stylesheet" href="style/profit.css" />
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
	<div class="top-container">
		<div class="wrapper-column">
			<div class="wrapper-column-item">
				<h2>current month</h2>
				<div class="top-container-item graph">

					<%
					Double[] sumWeek = new Double[4];
					int count = 0;
					int posRes = 1;

					try {
						String url = "jdbc:mysql://localhost:3306/cafeteria";
						String username = "root";
						String password = "uplan";

						Class.forName("com.mysql.cj.jdbc.Driver");
						Connection connection = DriverManager.getConnection(url, username, password);
						Statement statement = connection.createStatement();
						String sql = "SELECT SUM(TOTAL_PRICE) FROM ORDERS WHERE year(curdate()) = year(PURCHASE_TIME) and month(curdate()) = month(PURCHASE_TIME) GROUP BY WEEK(PURCHASE_TIME);";
						ResultSet result = statement.executeQuery(sql);

						while (result.next()) {
							sumWeek[count] = Double.parseDouble(result.getString(posRes));
							count++;
						}

					} catch (Exception exception) {
						out.println(exception);
					}
					%>
					<canvas id="chartjs_bar"></canvas>
				</div>
			</div>
			<div class="wrapper-column-item second-wrapper">
				<div class="second-wrapper-container">
					<div class="second-wrapper-container-item">
						<div class="button-option">
							<div class="button-option-item left-button">
								<span class="material-symbols-outlined"
									onclick="display('profit')"> menu_book </span>
							</div>
							<div class="button-option-item">
								<span class="material-symbols-outlined"
									onclick="display('menu_sales')"> paid </span>
							</div>
						</div>
					</div>
					<div class="second-wrapper-container-item">
						<h1 id="title-display">Profit in last 7 days</h1>
						<!--Menu sold in last 7 days-->
					</div>
				</div>
				<br />
				<div id="accumulation-profit">
					<table>
						<tr>
							<th>Day</th>
							<th>Victual Sold</th>
							<th>Total Sales</th>
							<th>Date</th>
						</tr>
						<%
						try {
							String url = "jdbc:mysql://localhost:3306/cafeteria";
							String username = "root";
							String password = "uplan";
							String sql = "SELECT DAYNAME(PURCHASE_TIME), COUNT(ORDER_ID), SUM(TOTAL_PRICE), PURCHASE_TIME FROM ORDERS WHERE YEARWEEK(PURCHASE_TIME) = YEARWEEK(NOW()) GROUP BY PURCHASE_TIME ORDER BY PURCHASE_TIME";

							Class.forName("com.mysql.cj.jdbc.Driver");
							Connection connection = DriverManager.getConnection(url, username, password);
							Statement statement = connection.createStatement();

							ResultSet result = statement.executeQuery(sql);
							while (result.next()) {
								String id = result.getString(1);
						%>
						<tr>
							<td>
								<%
								out.print(result.getString(1));
								%>
							</td>
							<td>
								<%
								out.print(result.getString(2));
								%>
							</td>
							<td>
								<%
								out.print("RM" + result.getString(3));
								%>
							</td>
							<td>
								<%
								out.print(result.getString(4));
								%>
							</td>
						</tr>
						<%
						}
						result.close();
						connection.close();
						} catch (Exception exception) {
						out.println(exception);
						}
						%>
					</table>
				</div>
				<div id="menu-sales">
					<table>
						<tr>
							<th>Num Sales</th>
							<th>Total Sales</th>
							<th>Victual ID</th>
							<th>Victual Name</th>
						</tr>
						<%
						try {
							String url = "jdbc:mysql://localhost:3306/cafeteria";
							String username = "root";
							String password = "uplan";
							String sql = "SELECT SUM(QUANTITY) AS NUM_SALES, SUM(QUANTITY * SUB_TOTAL ) AS TOTAL_SALES, A.VICTUAL_ID AS VICTUAL_ID, B.VICTUAL_NAME FROM ORDER_LINE A JOIN VICTUALS B ON A.VICTUAL_ID = B.VICTUAL_ID JOIN ORDERS C ON C.ORDER_ID = A.ORDER_ID WHERE YEARWEEK(PURCHASE_TIME) = YEARWEEK(NOW()) GROUP BY A.VICTUAL_ID ORDER BY NUM_SALES DESC";

							Class.forName("com.mysql.cj.jdbc.Driver");
							Connection connection = DriverManager.getConnection(url, username, password);
							Statement statement = connection.createStatement();

							ResultSet result = statement.executeQuery(sql);
							while (result.next()) {
								String id = result.getString(1);
						%>
						<tr>
							<td>
								<%
								out.print(result.getString(1));
								%>
							</td>
							<td>
								<%
								out.print("RM" + result.getString(2));
								%>
							</td>
							<td>
								<%
								out.print(result.getString(3));
								%>
							</td>
							<td>
								<%
								out.print(result.getString(4));
								%>
							</td>
						</tr>
						<%
						}
						result.close();
						connection.close();
						} catch (Exception exception) {
						out.println(exception);
						}
						%>
					</table>
				</div>
			</div>
		</div>

		<div class="top-container-item info">
			<h2>Information</h2>
			<div class="info-container">
				<div class="info-container-item">
					<span class="material-symbols-outlined"> next_week </span>
					<h1>Total Products</h1>
					<div class="content-info">
						<%
						try {
							String url = "jdbc:mysql://localhost:3306/cafeteria";
							String username = "root";
							String password = "uplan";

							Class.forName("com.mysql.cj.jdbc.Driver");
							Connection connection = DriverManager.getConnection(url, username, password);
							Statement statement = connection.createStatement();
							String sql = "SELECT COUNT(VICTUAL_ID) FROM VICTUALS";
							ResultSet result = statement.executeQuery(sql);
							result.next();
							out.println(result.getString(1) + " products");
							result.close();
							connection.close();
						} catch (Exception exception) {
							out.println(exception);
						}
						%>
					</div>
				</div>
				<div class="info-container-item">
					<span class="material-symbols-outlined"> contact_page </span>
					<h1>Total Users</h1>
					<div class="content-info">
						<%
						try {
							String url = "jdbc:mysql://localhost:3306/cafeteria";
							String username = "root";
							String password = "uplan";

							Class.forName("com.mysql.cj.jdbc.Driver");
							Connection connection = DriverManager.getConnection(url, username, password);
							Statement statement = connection.createStatement();
							String sql = "SELECT COUNT(CUSTOMER_ID) FROM CUSTOMER";
							ResultSet result = statement.executeQuery(sql);
							result.next();
							out.println(result.getString(1) + " users");
							result.close();
							connection.close();
						} catch (Exception exception) {
							out.println(exception);
						}
						%>
					</div>
				</div>
				<div class="info-container-item">
					<span class="material-symbols-outlined"> shopping_cart </span>
					<h1>Total Profit</h1>
					<div class="content-info">
						<%
						try {
							String url = "jdbc:mysql://localhost:3306/cafeteria";
							String username = "root";
							String password = "uplan";

							Class.forName("com.mysql.cj.jdbc.Driver");
							Connection connection = DriverManager.getConnection(url, username, password);
							Statement statement = connection.createStatement();
							String sql = "SELECT SUM(TOTAL_PRICE) FROM ORDERS";
							ResultSet result = statement.executeQuery(sql);
							result.next();
							out.println("RM" + result.getString(1));
							result.close();
							connection.close();
						} catch (Exception exception) {
							out.println(exception);
						}
						%>
					</div>
				</div>
				<div class="info-container-item">
					<span class="material-symbols-outlined"> list_alt </span>
					<h1>Total Orders</h1>
					<div class="content-info">
						<%
						try {
							String url = "jdbc:mysql://localhost:3306/cafeteria";
							String username = "root";
							String password = "uplan";

							Class.forName("com.mysql.cj.jdbc.Driver");
							Connection connection = DriverManager.getConnection(url, username, password);
							Statement statement = connection.createStatement();
							String sql = "SELECT COUNT(ORDER_ID) FROM ORDERS";
							ResultSet result = statement.executeQuery(sql);
							result.next();
							out.println(result.getString(1) + " orders");
							result.close();
							connection.close();
						} catch (Exception exception) {
							out.println(exception);
						}
						%>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="script/display_accumulate.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.3.2/chart.min.js"></script>
	<script>
		var ctx = document.getElementById("chartjs_bar").getContext('2d');
		var myChart = new Chart(ctx, {
			type : 'bar',
			data : {
				labels : [ 'Week 1', 'Week 2', 'Week 3', 'Week 4' ],
				datasets : [ {
					label : 'Total Sales(RM)',
					backgroundColor : 'whitesmoke',
					borderColor : 'rgba(60,141,188,0.8)',
					pointRadius : false,
					pointColor : '#072c51',
					pointStrokeColor : 'rgba(60,141,188,1)',
					pointHighlightFill : '#fff',
					pointHighlightStroke : 'rgba(60,141,188,1)',
					barThickness : 100,
					data : [
	<%=sumWeek[0]%>
		,
	<%=sumWeek[1]%>
		,
	<%=sumWeek[2]%>
		,
	<%=sumWeek[3]%>
		],
				} ]
			},
			options : {
				legend : {
					display : true,
					position : 'bottom',

					labels : {
						fontColor : '#8ee4af',
						fontFamily : 'Circular Std Book',
						fontSize : 14,
					}
				},
			}
		});
	</script>
</body>
</html>
