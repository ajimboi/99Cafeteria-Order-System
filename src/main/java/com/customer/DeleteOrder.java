package com.customer;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/Customer/deleteOrder")
public class DeleteOrder extends HttpServlet {
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		Integer victualID = Integer.parseInt(request.getParameter("victual_id"));
		Integer orderID = Integer.parseInt(request.getParameter("order_id"));
		String customerID = request.getParameter("customer_id");

		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd ");
		LocalDateTime now = LocalDateTime.now();

		PrintWriter out = response.getWriter();

		String url = "jdbc:mysql://localhost:3306/cafeteria";
		String username = "root";
		String password = "uplan";

		try {

			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connection = DriverManager.getConnection(url, username, password);

			PreparedStatement prepared4 = connection
					.prepareStatement("UPDATE ORDERS SET  TOTAL_PRICE = ? WHERE CUSTOMER_ID = ? AND PURCHASE_TIME = ?");
			PreparedStatement prepared6 = connection.prepareStatement(
					"UPDATE INVOICE SET TOTAL_INVOICE = ? WHERE CUSTOMER_ID = ? AND INVOICE_DATE = ?");

			PreparedStatement prepared2 = connection
					.prepareStatement("DELETE FROM INVOICE WHERE CUSTOMER_ID = ? AND ORDER_ID = ?");
			PreparedStatement prepared3 = connection
					.prepareStatement("DELETE FROM ORDERS WHERE CUSTOMER_ID = ? AND ORDER_ID = ?");

			PreparedStatement prepared = connection
					.prepareStatement("DELETE FROM ORDER_LINE WHERE VICTUAL_ID = ? AND ORDER_ID = ?");
			prepared.setInt(1, victualID);
			prepared.setInt(2, orderID);

			prepared.executeUpdate();

			Statement statement1 = connection.createStatement();
			ResultSet result = statement1.executeQuery(
					"SELECT SUM(SUB_TOTAL) FROM ORDER_LINE INNER JOIN ORDERS ON ORDER_LINE.ORDER_ID = ORDERS.ORDER_ID WHERE ORDERS.CUSTOMER_ID ="
							+ customerID + " AND PURCHASE_TIME =" + "'" + dtf.format(now) + "'");
			result.next();
			String newPrice = result.getString(1);
			System.out.println(newPrice);

			if (newPrice != null) {
				double priceUpdated = Double.parseDouble(newPrice);
				System.out.println(priceUpdated);
				// update price for orders and invoice

				prepared4.setDouble(1, priceUpdated);
				prepared4.setString(2, customerID);
				prepared4.setString(3, dtf.format(now));
				prepared4.executeUpdate();

				prepared6.setDouble(1, priceUpdated);
				prepared6.setString(2, customerID);
				prepared6.setString(3, dtf.format(now));
				prepared6.executeUpdate();

			} else {
				// delete all stuff from orders, invoice
				System.out.println(newPrice + "bro");
				prepared2.setString(1, customerID);
				prepared2.setInt(2, orderID);
				prepared2.executeUpdate();

				prepared3.setString(1, customerID);
				prepared3.setInt(2, orderID);
				prepared3.executeUpdate();
			}

			connection.close();
			prepared.close();

			response.sendRedirect("cart.jsp");
		} catch (Exception exception) {
			System.out.println(exception);
		}

	}
}
