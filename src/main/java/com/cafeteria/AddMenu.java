package com.cafeteria;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/Cafeteria/addMenu")
@MultipartConfig(maxFileSize = 51200000)
public class AddMenu extends HttpServlet {
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String categoryID = request.getParameter("categoryID");
		String victualName = request.getParameter("victualName");
		double price = Double.parseDouble(request.getParameter("price"));
		String description = request.getParameter("description");
		String availability = "true";
		Part part = request.getPart("myfile");

		PrintWriter out = response.getWriter();

		String url = "jdbc:mysql://localhost:3306/cafeteria";
		String username = "root";
		String password = "uplan";

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connection = DriverManager.getConnection(url, username, password);

			PreparedStatement prepared = connection
					.prepareStatement("INSERT INTO victuals values(default,?,?,?,?,?,?)");

			prepared.setString(1, categoryID);
			prepared.setString(2, victualName);
			prepared.setDouble(3, price);
			prepared.setString(4, availability);
			prepared.setString(5, description);

			InputStream is = part.getInputStream();

			prepared.setBlob(6, is);

			prepared.executeUpdate();
			connection.close();
			prepared.close();

			request.setAttribute("isMenuAdded", Boolean.TRUE);
			request.setAttribute("victualName", victualName);
			RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
			rd.include(request, response);

		} catch (Exception exception) {
			out.println(exception);
		}

	}
}
