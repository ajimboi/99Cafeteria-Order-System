package com.cafeteria;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/Cafeteria/processOrder")
public class ProcessOrder extends HttpServlet {

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		Integer orderID = Integer.parseInt(request.getParameter("order_id"));
		
		PrintWriter out = response.getWriter();
		String url = "jdbc:mysql://localhost:3306/cafeteria";
		String username = "root";
		String password = "uplan";
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connection = DriverManager.getConnection(url, username, password);
			
			PreparedStatement prepared = connection.prepareStatement("UPDATE ORDERS SET STATUS_ORDER = ? WHERE ORDER_ID = ?");
			prepared.setString(1, "COMPLETED");
			prepared.setInt(2, orderID);
			prepared.executeUpdate();
			connection.close();
			prepared.close();
			response.sendRedirect("home.jsp");
		}catch(Exception exception) {
			out.println(exception);
		}
		
	}
	
}
