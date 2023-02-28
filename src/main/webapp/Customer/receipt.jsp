<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="style/receipt.css" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Insert title here</title>
</head>
<body>
	<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	if (session.getAttribute("customer_id") == null) {
		response.sendRedirect("login.jsp");
	}
	String customer_credential = (String) session.getAttribute("customer_id");
	%>
	<h1>Invoice</h1>

	<div class='seperator'>

		<div class='seperator-item'>
			<div class='top-banner'>
				<div class='top-banner-item' style='margin: 5px 0px;'>
					<img src="images/brand_logo.jpeg" alt="" height="100px"
						style='border-radius: 25px;' />
				</div>
				<div class='top-banner-item'>
					<div class='right-banner'>
						<div class='right-banner-item'>UPLAN ORDER</div>
						<div style='padding: 5px 0px'></div>
						<div class='right-banner-item'>UiTM Tapah</div>
						<div class='right-banner-item'>Tapah Road</div>
						<div class='right-banner-item'>Perak</div>
					</div>
				</div>
			</div>
			<table class="table table-hover">
				<thead>
					<tr>
						<th>Victual</th>
						<th>Quantity</th>
						<th class="text-center">Price</th>

					</tr>
				</thead>
				<tbody>
					<%
					double sum = 0.00;
					try {
						String uname = (String) session.getAttribute("username");
						String url = "jdbc:mysql://localhost:3306/cafeteria";
						String username = "root";
						String password = "uplan";

						Class.forName("com.mysql.cj.jdbc.Driver");
						Connection connection = DriverManager.getConnection(url, username, password);
						Statement statement = connection.createStatement();
						String sql = " SELECT VICTUAL_NAME,  QUANTITY, SUB_TOTAL FROM ORDER_LINE INNER JOIN ORDERS ON ORDER_LINE.ORDER_ID = ORDERS.ORDER_ID INNER JOIN VICTUALS ON ORDER_LINE.VICTUAL_ID = VICTUALS.VICTUAL_ID WHERE ORDERS.CUSTOMER_ID = "
						+ customer_credential + " AND PURCHASE_TIME = CURDATE()";
						ResultSet rs = statement.executeQuery(sql);

						while (rs.next()) {
					%>
					<tr>
						<td><%=rs.getString(1)%></td>
						<td><%=rs.getString(2)%></td>
						<td>RM <%=rs.getString(3)%></td>
					</tr>


					<%
					sum += Double.parseDouble(rs.getString(3));
					}
					%>
					<tr>
						<td></td>
						<td></td>
						<td style='border-top: 2px solid purple;'>RM <%=sum%></td>
					</tr>
			</table>
			<%
			} catch (Exception e) {
			System.out.print(e);
			}
			%>
		</div>
		<div class='seperator-item payment'>
			<h1>Payment Details</h1>
			<div class='payment-details'>
				<div class='payment-details-item'>
					<input type="text" placeholder="card number" required />
				</div>
				<div class='payment-details-item'>
					<input type="text" placeholder="cardholder name" required />
				</div>
				<div class='payment-details-item'>
					<div class="cv">
						<div class="cv-item">
							<input type="text" placeholder="card number" required />
						</div>
						<div class="cv-item">
							<input type="text" placeholder="valid thru" required />
						</div>
						<div class="cv-item">
							<input type="text" placeholder="cv" required />
						</div>
					</div>
				</div>
				<div class='payment-details-item'>
					<a href="appreciation.jsp">
						<button>Confirm and Pay</button>
					</a>
				</div>
			</div>
		</div>
	</div>

</body>
</html>