package com.cafeteria;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/Cafeteria/addCategory")
public class AddCategory extends HttpServlet {

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String categoryName = request.getParameter("categoryName");

		PrintWriter out = response.getWriter();

		String url = "jdbc:mysql://localhost:3306/cafeteria";
		String username = "root";
		String password = "uplan";

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connection = DriverManager.getConnection(url, username, password);
			PreparedStatement prepared = connection.prepareStatement("INSERT INTO category values(default,?)");
			prepared.setString(1, categoryName);

			prepared.executeUpdate();
			connection.close();
			prepared.close();
			request.setAttribute("isCategoryAdded", Boolean.TRUE);
			request.setAttribute("categoryName", categoryName);
			RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
			rd.include(request, response);

		} catch (Exception exception) {
			out.println(exception);
		}

	}

}
