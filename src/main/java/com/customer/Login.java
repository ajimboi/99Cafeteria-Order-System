package com.customer;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/Customer/login")
public class Login extends HttpServlet {

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String userName = request.getParameter("username");
		String passWord = request.getParameter("password");

		String url = "jdbc:mysql://localhost:3306/cafeteria";
		String username = "root";
		String password = "uplan";

		PrintWriter out = response.getWriter();

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connection = DriverManager.getConnection(url, username, password);

			Statement statement = connection.createStatement();

			ResultSet result = statement.executeQuery(
					"SELECT * FROM customer WHERE customer_id='" + userName + "'and password='" + passWord + "'");

			if (result.next()) {
				HttpSession session = request.getSession();
				session.setAttribute("customer_id", result.getString("customer_id"));
				response.sendRedirect("home.jsp");
			} else {
				request.setAttribute("isError", Boolean.TRUE);
				RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
				rd.include(request, response);
			}

			connection.close();

		} catch (Exception exception) {
			out.println(exception);
		}

	}

}
