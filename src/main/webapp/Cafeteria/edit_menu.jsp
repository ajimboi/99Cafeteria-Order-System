<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<link rel="stylesheet" href="style/edit_menu.css" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
<body>
	<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	if (session.getAttribute("employee_id") == null) {
		response.sendRedirect("login.jsp");
	}
	%>
	<%
	String imagePos = request.getParameter("imagePos");
	String id = request.getParameter("id");
	String victualName = request.getParameter("victualName");
	String price = request.getParameter("price");
	String description = request.getParameter("description");
	%>
	<div id="updateMenuModal" class=" updateMenus">
		<div class="modal-content the-update-menu">
			<div class="modal-content-item model-picture">
				<input accept="image/*" type="file" name="myfile" id="imgInp"
					form="updateMenuForm" /> <img id="thePic"
					src="picture.jsp?id=<%=imagePos%>" />

			</div>
			<div class="model-content-item model-form">
				<div class="model-form-item">
					<form action="updateMenu" id="updateMenuForm" method="post"
						enctype="multipart/form-data">
						<input type="hidden" name="victualID" value="<%=id%>" /> <label
							for="availability">Availability</label> <br /> <select
							name="availability" id="availability">
							<option value="true">True</option>
							<option value="false">False</option>
						</select> <label for="categoryID">Category</label> <br /> <select
							name="categoryID" id="category">
							<%
							try {
								String url = "jdbc:mysql://localhost:3306/cafeteria";
								String username = "root";
								String password = "uplan";

								Class.forName("com.mysql.cj.jdbc.Driver");
								Connection connection = DriverManager.getConnection(url, username, password);
								Statement statement = connection.createStatement();
								String sql = "SELECT * FROM category";
								ResultSet result = statement.executeQuery(sql);

								while (result.next()) {
									String ids = result.getString(1);
									String cname = result.getString(2);
							%>

							<option value="<%=ids%>"><%=cname%></option>

							<%
							}
							result.close();
							connection.close();
							} catch (Exception exception) {

							}
							%>
						</select> <br /> <label for="victualName">Name</label> <br /> <input
							name="victualName" type="text" value="<%=victualName%>" /><br />
						<label for="price">Price</label> <br /> <input name="price"
							type="text" value="<%=price%>" /><br /> <label
							for="description">Food description</label> <br /> <input
							name="description" type="text" value="<%=description%>" />
					</form>
				</div>
				<div class="model-form-item">
					<input type="submit" form="updateMenuForm" value="Edit menu" />
				</div>
			</div>
			<div style='color: black;'>
				<form style="display: none;" action="deleteMenu" id="deleteForm"
					method="post">
					<input type="hidden" name='victualID' value="<%=id%>" />
				</form>
				<button
					style="border-radius: 25px; cursor: pointer; border-color: purple;"
					form="deleteForm" type="submit">
					<span class="material-symbols-outlined"> delete </span>
				</button>
			</div>
		</div>
	</div>
	<script src="script/menu_pic_upload.js"></script>
</body>
</html>