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

@WebServlet("/Customer/addOrder")
public class Order extends HttpServlet {

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd ");
		LocalDateTime now = LocalDateTime.now();

		java.util.Date dt = new java.util.Date();

		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");

		String currentTime = sdf.format(dt);

		Integer victualID = Integer.parseInt(request.getParameter("victualID"));
		Integer quantity = Integer.parseInt(request.getParameter("quantity"));
		Double price = Double.parseDouble(request.getParameter("price"));
		String customerID = request.getParameter("customer_id");
		Double subTotalPrice = price * quantity;

		PrintWriter out = response.getWriter();

		String url = "jdbc:mysql://localhost:3306/cafeteria";
		String username = "root";
		String password = "uplan";

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connection = DriverManager.getConnection(url, username, password);

			Statement statement = connection.createStatement();
			ResultSet check_single_order = statement.executeQuery("SELECT * FROM ORDERS WHERE CUSTOMER_ID ="
					+ customerID + " AND PURCHASE_TIME =" + "'" + dtf.format(now) + "'");
			System.out.println(dtf.format(now));
			Boolean order_even_once = check_single_order.next();
			System.out.println(order_even_once);

			PreparedStatement prepared = connection.prepareStatement("INSERT INTO ORDERS values(default,?,?,?,?,?)");
			PreparedStatement prepared2 = connection.prepareStatement("INSERT INTO ORDER_LINE values(default,?,?,?,?)");
			PreparedStatement prepared3 = connection.prepareStatement("INSERT INTO ORDER_LINE values(default,?,?,?,?)");
			PreparedStatement prepared4 = connection
					.prepareStatement("UPDATE ORDERS SET  TOTAL_PRICE = ? WHERE CUSTOMER_ID = ? AND PURCHASE_TIME = ?");
			PreparedStatement prepared5 = connection.prepareStatement("INSERT INTO INVOICE values(default,?,?,?,?)");
			PreparedStatement prepared6 = connection.prepareStatement(
					"UPDATE INVOICE SET TOTAL_INVOICE = ? WHERE CUSTOMER_ID = ? AND INVOICE_DATE = ?");
			if (!order_even_once) {

				prepared.setString(1, customerID);
				prepared.setString(2, "1234");
				prepared.setString(3, "PROCESSING");
				prepared.setString(4, currentTime);
				prepared.setDouble(5, subTotalPrice);
				prepared.execute();
				check_single_order.close();
				// invoice here
				Statement statement1 = connection.createStatement();
				ResultSet check_single_order1 = statement1.executeQuery("SELECT * FROM ORDERS WHERE CUSTOMER_ID ="
						+ customerID + " AND PURCHASE_TIME =" + "'" + dtf.format(now) + "'");
				check_single_order1.next();
				try {

					String order_not = check_single_order1.getString(1);
					System.out.println(order_not);
					prepared2.setInt(1, Integer.parseInt(order_not));
					prepared2.setInt(2, victualID);
					prepared2.setInt(3, quantity);
					prepared2.setDouble(4, subTotalPrice);
					prepared2.executeUpdate();

				} catch (Exception exception) {
					System.out.println(exception);
				} finally {
					try {

						System.out.println(check_single_order1.getString(2));
						prepared5.setString(1, check_single_order1.getString(2));
						prepared5.setInt(2, Integer.parseInt(check_single_order1.getString(1)));
						prepared5.setString(3, dtf.format(now));
						prepared5.setDouble(4, Double.parseDouble(check_single_order1.getString(6)));
						prepared5.executeUpdate();
					} catch (Exception exception) {
						out.println(exception);
					} finally {
						check_single_order1.close();
					}

				}

			} else {

				prepared3.setInt(1, Integer.parseInt(check_single_order.getString(1)));
				prepared3.setInt(2, victualID);
				prepared3.setInt(3, quantity);
				prepared3.setDouble(4, subTotalPrice);
				prepared3.executeUpdate();

				Double latestPrice = Double.parseDouble(check_single_order.getString(6)) + subTotalPrice;

				prepared4.setDouble(1, latestPrice);
				prepared4.setString(2, customerID);
				prepared4.setString(3, dtf.format(now));
				prepared4.executeUpdate();

				// update invoice
				try {
					Statement statement2 = connection.createStatement();
					ResultSet check_single_order2 = statement2.executeQuery("SELECT * FROM ORDERS WHERE CUSTOMER_ID ="
							+ customerID + " AND PURCHASE_TIME =" + "'" + dtf.format(now) + "'");
					check_single_order2.next();

					prepared6.setDouble(1, Double.parseDouble(check_single_order2.getString(6)));
					prepared6.setString(2, customerID);
					prepared6.setString(3, dtf.format(now));
					prepared6.executeUpdate();
				} catch (Exception exception) {
					out.println(exception);
				}

			}

			request.setAttribute("isOrderMade", Boolean.TRUE);
			RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
			rd.include(request, response);

		} catch (Exception exception) {
			out.println(exception);
		}

	}

}
