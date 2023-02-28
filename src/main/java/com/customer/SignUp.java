package com.customer;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/Customer/signup")
public class SignUp extends HttpServlet {

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String username_input = request.getParameter("username");
		String fullname = request.getParameter("fullname");
		String tel_no = request.getParameter("tel");
		String password_input = request.getParameter("password");
		String retypePassword = request.getParameter("retype_password");

		PrintWriter out = response.getWriter();

		String url = "jdbc:mysql://localhost:3306/cafeteria";
		String username = "root";
		String password = "uplan";

		if (password_input.equalsIgnoreCase(retypePassword)) {
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection connection = DriverManager.getConnection(url, username, password);
				PreparedStatement prepared = connection.prepareStatement("INSERT INTO customer values(?,?,?,?)");
				prepared.setString(1, username_input);
				prepared.setString(2, fullname);
				prepared.setString(3, tel_no);
				prepared.setString(4, password_input);

				prepared.executeUpdate();
				connection.close();
				prepared.close();

				request.setAttribute("isAccountAdded", Boolean.TRUE);

			} catch (Exception exception) {
				out.println(exception);
			}
		}

		RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
		rd.include(request, response);
	}
}
