<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="style/home.css" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
</head>
<body>
	<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	if (session.getAttribute("customer_id") == null) {
		response.sendRedirect("login.jsp");
	}
	String customer_credential = (String) session.getAttribute("customer_id");
	%>
	<div class="top-navigation-bar">
		<div class="top-navigation-bar-item header-logo">
			<!-- <h2>Menu</h2> -->
			<a href="home.jsp"><img src="images/brand_logo.jpeg" alt=""
				height="50px" /></a>

		</div>
		<div class="top-navigation-bar-item">
			<a href="#grossing-content"><span
				class="material-symbols-outlined"> restaurant </span></a>

		</div>
		<div class="top-navigation-bar-item">
			<a href='cart.jsp'><span class="material-symbols-outlined">
					shopping_cart </span></a>
		</div>

		<div class="top-navigation-bar-item">
			<span class="material-symbols-outlined " onclick="openNav()">
				receipt_long </span>
		</div>
		<div class="top-navigation-bar-item">
			<form action="logout" method="post">
				<button type="submit">
					<span class="material-symbols-outlined"> logout </span>
				</button>
			</form>

		</div>
	</div>

	<div id="mySidenav" class="sidenav">
		<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
		<div class='past-order'>
			<h2>Past Order's</h2>
			<section>
				<header>
					<div class="col">Quantity</div>
					<div class="col">Victual</div>
					<div class="col">Price</div>
					<div class="col">Date</div>
				</header>
				<%
				try {

					String url = "jdbc:mysql://localhost:3306/cafeteria";
					String username = "root";
					String password = "uplan";

					Class.forName("com.mysql.cj.jdbc.Driver");
					Connection connection = DriverManager.getConnection(url, username, password);
					Statement statement = connection.createStatement();
					String sql = " SELECT  QUANTITY, SUB_TOTAL, PURCHASE_TIME, VICTUAL_NAME FROM ORDER_LINE INNER JOIN ORDERS ON ORDER_LINE.ORDER_ID = ORDERS.ORDER_ID INNER JOIN VICTUALS ON ORDER_LINE.VICTUAL_ID = VICTUALS.VICTUAL_ID WHERE ORDERS.CUSTOMER_ID = "
					+ customer_credential + " AND PURCHASE_TIME != CURDATE();";
					ResultSet result = statement.executeQuery(sql);

					while (result.next()) {
				%>

				<div class="row">
					<div class="col"><%=result.getString(1)%></div>
					<div class="col">
						RM
						<%=result.getString(2)%></div>
					<div class="col"><%=result.getString(3)%></div>
					<div class="col"><%=result.getString(4)%></div>
				</div>
				<%
				}
				result.close();
				} catch (Exception exception) {

				}
				%>
			</section>
		</div>
	</div>

	<div class="menu-displayer">
		<%
		try {
			String url = "jdbc:mysql://localhost:3306/cafeteria";
			String username = "root";
			String password = "uplan";

			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connection = DriverManager.getConnection(url, username, password);
			Statement statement = connection.createStatement();
			Statement statement2 = connection.createStatement();

			String sql2 = "SELECT * FROM category ";

			ResultSet category = statement2.executeQuery(sql2);
			while (category.next()) {
				String cid = category.getString(1);
				String cin = category.getString(2);
				out.println("<div style='width: 100vw; color:#61116a'> <h2>" + cin + "</h2></div>");
				String sql = "SELECT * FROM victuals where category_id =" + cid; //where availability='true' 
				ResultSet result = statement.executeQuery(sql);
				while (result.next()) {

			String id = result.getString(1);
		%>
		<div class="menu-displayer-item">
			<div class="menus">
				<div class="menus-item">
					<img src="picture.jsp?id=<%=id%>" width="100" height="100">
				</div>
				<div id="menus-item-text" class="menus-item">
					<div class="menus-top">
						<div class="menus-top-item menus-top-title">
							<h2>
								<%
								out.print(result.getString(3));
								%>
							</h2>
						</div>
						<div class="menus-top-item">
							<%
							if (result.getString(5).equalsIgnoreCase("false")) {
							%>
							<span id="block" class="material-symbols-outlined"> block
							</span>
							<%
							}
							%>

						</div>

					</div>
					<div class="menus-top-item">
						<%
						if (result.getString(5).equalsIgnoreCase("false")) {
						%>
						<p>Sorry, Out of order!</p>
						<%
						} else {
						%>
						<form action='addOrder' method='post'>
							<input type='hidden' value='<%=result.getString(1)%>'
								name='victualID' /> <input type='hidden'
								value='<%=customer_credential%>' name='customer_id' /> <input
								type='number' name='quantity' /> <input type='hidden'
								name='price' value='<%=result.getString(4)%>' /> <input
								type="submit" value="order" />
						</form>
						<%
						}
						%>



					</div>
					<p>
						RM<%
					out.print(result.getString(4));
					%>
					</p>
					<p>
						<%
						out.print(result.getString(6));
						%>
					</p>
				</div>
			</div>
		</div>
		<%
		}
		result.close();
		}

		category.close();
		connection.close();
		} catch (Exception e) {
		out.println(e);
		}
		%>

	</div>

	<div id="msg-container" style="display: none">
		<%
		boolean isOrderMade = Boolean.TRUE == request.getAttribute("isOrderMade");

		if (isOrderMade) {
		%>
		<p>Victual is added to cart</p>
		<script src="script/msg_container.js"></script>
		<%
		}
		%>
	</div>

	<script>
		function openNav() {
			let width = screen.width;
			if (width < 1300) {
				document.getElementById("mySidenav").style.width = "90vw";
			} else {
				document.getElementById("mySidenav").style.width = "25vw";
			}

			document.getElementById("mySidenav").style.boxShadow = "rgba(0, 0, 0, 0.25) 0px 54px 55px, rgba(0, 0, 0, 0.12) 0px -12px 30px, rgba(0, 0, 0, 0.12) 0px 4px 6px, rgba(0, 0, 0, 0.17) 0px 12px 13px, rgba(0, 0, 0, 0.09) 0px -3px 5px";
		}

		function closeNav() {
			document.getElementById("mySidenav").style.width = "0";
			document.getElementById("mySidenav").style.boxShadow = "none";
		}
	</script>
</body>
</html>