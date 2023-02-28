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

@WebServlet("/Cafeteria/deleteMenu")
public class DeleteMenu extends HttpServlet {

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		Integer victualID = Integer.parseInt(request.getParameter("victualID"));
		
		PrintWriter out = response.getWriter();
		
		String url = "jdbc:mysql://localhost:3306/cafeteria";
		String username = "root";
		String password = "uplan";
		
		try {
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connection = DriverManager.getConnection(url, username, password);
			PreparedStatement prepared = connection.prepareStatement("DELETE FROM victuals WHERE victual_id = ?");
			prepared.setInt(1, victualID);
			
			prepared.executeUpdate();
			connection.close();
			prepared.close();
			response.sendRedirect("home.jsp");
		}catch(Exception exception) {
			out.println(exception);
		}
		
	}
	
}
