<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="style/cart.css" />
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
			<a href="home.jsp"><img src="images/brand_logo.jpeg" alt=""
				height="50px" /></a>
		</div>
		<div class="top-navigation-bar-item">
			<a href="home.jsp"><span class="material-symbols-outlined">
					restaurant </span></a>

		</div>
		<div class="top-navigation-bar-item">
			<span class="material-symbols-outlined"> shopping_cart </span>
		</div>


		<div class="top-navigation-bar-item">
			<form action="logout" method="post">
				<button type="submit">
					<span class="material-symbols-outlined"> logout </span>
				</button>
			</form>
		</div>
	</div>

	<div class='sided-container'>
		<%
		try {
			String url = "jdbc:mysql://localhost:3306/cafeteria";
			String username = "root";
			String password = "uplan";

			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connection = DriverManager.getConnection(url, username, password);
			Statement statement = connection.createStatement();
			String sql = "SELECT * FROM ORDERS WHERE CUSTOMER_ID=" + customer_credential + " AND PURCHASE_TIME = CURDATE()";
			ResultSet result = statement.executeQuery(sql);

			if (!result.next()) {
		%>
		<div class='empty-cart'>
			<div class='empty-cart-item'>
				<img src="images/empty-cart.png" alt="" style="width: 100%;">
			</div>
			<div class='empty-cart-item'>
				<h1>Well.. the cart is empty I think..</h1>
			</div>

			<img src="images/emoticon.png" alt="">

		</div>


		<%
		} else {
		%>
		<div class='sided-container-item' id='left-container'>
			<h1 class='your-order'>Your Order</h1>

			<%
			try {
				String url2 = "jdbc:mysql://localhost:3306/cafeteria";
				String username2 = "root";
				String password2 = "uplan";

				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection connection2 = DriverManager.getConnection(url2, username2, password2);
				Statement statement2 = connection.createStatement();
				String sql2 = "SELECT ORDER_LINE.ORDER_ID, QUANTITY, SUB_TOTAL, DESCRIPTION, VICTUAL_NAME, PRICE, VICTUALS.VICTUAL_ID  FROM ORDER_LINE INNER JOIN ORDERS ON ORDER_LINE.ORDER_ID = ORDERS.ORDER_ID INNER JOIN VICTUALS ON ORDER_LINE.VICTUAL_ID = VICTUALS.VICTUAL_ID WHERE ORDERS.CUSTOMER_ID ="
				+ customer_credential + " AND PURCHASE_TIME = CURDATE()";
				ResultSet result2 = statement.executeQuery(sql2);

				while (result2.next()) {
					String id = result2.getString(7);
					String orderID = result2.getString(1);
			%>

			<div class="order-each">
				<div class='picture-item'>
					<img src="picture.jsp?id=<%=id%>" width="100%" height="100%">
				</div>
				<div class='concurrent'>
					<div class='concurrent-each'>
						<div class='concurrent-each-item'><%=result2.getString(2)%>
							Qty (RM
							<%=result2.getString(6)%>
							each)
						</div>
						<div class='concurrent-each-item'>
							RM
							<%=result2.getString(3)%></div>
						<div class='concurrent-each-item description'><%=result2.getString(4)%></div>
						<!-- <div>+ -</div>  -->
					</div>
				</div>
				<div class='delete-item'>
					<form action="deleteOrder" method="post">
						<input type="hidden" value="<%=id%>" name="victual_id" /> <input
							type="hidden" value="<%=orderID%>" name="order_id" /> <input
							type="hidden" value="<%=customer_credential%>" name="customer_id" />
						<button type="submit" id="process-button">
							<span class="material-symbols-outlined"> delete </span>
						</button>
					</form>
				</div>
			</div>

			<%
			}
			result2.close();
			connection2.close();
			} catch (Exception exception) {
			out.println(exception);
			}
			%>


		</div>
		<div class='sided-container-item' id='right-container'>
			<div class='checkout-box'>
				<div class='checkout-box-item'>
					<h1>Are you done?</h1>
					<h2>Click button below to checkout.. :)</h2>
					<a href='receipt.jsp'><button>CHECKOUT</button></a>

				</div>
				<div class='checkout-box-item lol'>
					<script src="https://cdn.lordicon.com/ritcuqlt.js"></script>
					<lord-icon src="https://cdn.lordicon.com/cllunfud.json"
						trigger="loop" delay="2000" style="width:200px;height:200px">
					</lord-icon>
				</div>
			</div>
		</div>
		<%
		}
		result.close();
		connection.close();
		} catch (Exception exception) {
		out.println(exception);
		}
		%>


	</div>



</body>
</html>