<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page trimDirectiveWhitespaces="true"%>


<%
String id = request.getParameter("id");
try {
	String url = "jdbc:mysql://localhost:3306/cafeteria";
	String username = "root";
	String password = "uplan";
	String sql = "SELECT * FROM victuals where victual_id=? ";

	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection con = DriverManager.getConnection(url, username, password);
	PreparedStatement ps = con.prepareStatement("select * from victuals where victual_id=?");
	ps.setString(1, id);
	ResultSet rs = ps.executeQuery();
	if (rs.next()) {
		Blob blob = rs.getBlob("picture");
		byte byteArray[] = blob.getBytes(1, (int) blob.length());
		response.setContentType("image/gif");
		OutputStream os = response.getOutputStream();
		os.write(byteArray);
		os.flush();
		os.close();
		return;
	} else {
		System.out.println("No image found with this id.");
	}
} catch (Exception e) {
	out.println(e);
}
%>
