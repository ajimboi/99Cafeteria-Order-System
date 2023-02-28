package com.cafeteria;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/Cafeteria/updateMenu")
@MultipartConfig(maxFileSize = 51200000)
public class UpdateMenu extends HttpServlet {

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

		Integer victualID = Integer.parseInt(request.getParameter("victualID"));

		String availability = request.getParameter("availability");
		String categoryID = request.getParameter("categoryID");
		String victualName = request.getParameter("victualName");

		double price = Double.parseDouble(request.getParameter("price"));
		String description = request.getParameter("description");

		Part part = request.getPart("myfile");

		PrintWriter out = response.getWriter();

		String url = "jdbc:mysql://localhost:3306/cafeteria";
		String username = "root";
		String password = "uplan";

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connection = DriverManager.getConnection(url, username, password);

			if (part.getSize() == 0) {
				PreparedStatement prepared = connection.prepareStatement(
						"UPDATE victuals SET category_id = ?, victual_name = ?, price = ?, availability = ?, description = ? WHERE victual_id = ?");

				prepared.setString(1, categoryID);
				prepared.setString(2, victualName);
				prepared.setDouble(3, price);
				prepared.setString(4, availability);
				prepared.setString(5, description);

				prepared.setInt(6, victualID);
				prepared.executeUpdate();
				connection.close();
				prepared.close();
			} else {
				PreparedStatement prepared = connection.prepareStatement(
						"UPDATE victuals SET category_id = ?, victual_name = ?, price = ?, availability = ?, description = ?, picture = ? WHERE victual_id = ?");

				prepared.setString(1, categoryID);
				prepared.setString(2, victualName);
				prepared.setDouble(3, price);
				prepared.setString(4, availability);
				prepared.setString(5, description);

				InputStream is = part.getInputStream();

				prepared.setBlob(6, is);
				prepared.setInt(7, victualID);
				prepared.executeUpdate();
				connection.close();
				prepared.close();
			}

			response.sendRedirect("home.jsp");

		} catch (Exception exception) {
			out.println(exception);
		}

	}

}
