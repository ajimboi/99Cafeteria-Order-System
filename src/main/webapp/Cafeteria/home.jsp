<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<!-- CTRL SHIFT F TO FORMAT, CTRL F5 TO RELOAD BROWSER -->
<html>
<head>
<meta charset="ISO-8859-1">
<title></title>
<link rel="stylesheet" href="style/home.css" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
</head>
<body>

	<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	if (session.getAttribute("employee_id") == null) {
		response.sendRedirect("login.jsp");
	}
	%>

	<div class="top-navigation-bar">
		<div class="top-navigation-bar-item">
			<!-- <h2>Menu</h2> -->
			<a href="#menu-content"><span class="material-symbols-outlined">
					storefront </span></a>
		</div>
		<div class="top-navigation-bar-item">
			<a href="#grossing-content"><span
				class="material-symbols-outlined"> account_balance_wallet </span></a>

		</div>
		<div class="top-navigation-bar-item">
			<a href="#order-content"> <span class="material-symbols-outlined">
					list_alt </span>
			</a>
		</div>
		<div class="top-navigation-bar-item">
			<a href="profile.jsp"> <span class="material-symbols-outlined">
					badge </span></a>
		</div>
	</div>
	<div class="content">
		<div id="menu-content" class="menu-content">
			<div class="title-content">
				<div class="menu-title-content">
					<div class="menu-title-content-item">
						<h1>Menu List</h1>
					</div>
					<div class="menu-title-content-item">
						<span id="add_menu" class="material-symbols-outlined"> add
						</span>
					</div>
					<div class="menu-title-content-item">
						<span id="category_option" class="material-symbols-outlined">
							category </span>
					</div>
				</div>
			</div>
			<div id="categoryModal" class="modal">
				<div class="modal-content  the-modal-category">
					<form action="addCategory" method="post">
						<label for="categoryName">Category Name</label> <br /> <input
							name="categoryName" type="text" required /> <input type="submit"
							value="Place new category" />
					</form>
				</div>
			</div>
			<div id="menuModal" class="modal">
				<div class="modal-content">
					<div class="model-content-item model-picture">
						<!-- <img src="images/test.jpg" alt="" />  -->
						<input accept="image/*" type="file" name="myfile" id="imgInp"
							form="myform" /> <img id="thePic" src="images/upload.jpg" />
					</div>
					<div class="model-content-item model-form">
						<div class="model-form-item">
							<form action="addMenu" id="myform" method="post"
								enctype="multipart/form-data">
								<label for="categoryID">Category</label> <br /> <select
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
											String id = result.getString(1);
											String cname = result.getString(2);
									%>

									<option value="<%=id%>"><%=cname%></option>

									<%
									}
									result.close();
									connection.close();
									} catch (Exception exception) {

									}
									%>
								</select> <br /> <label for="victualName">Name</label> <br /> <input
									name="victualName" type="text" required /><br /> <label
									for="price">Price</label> <br /> <input name="price"
									type="text" required /><br /> <label for="description">Food
									description</label> <br /> <input name="description" type="text"
									required />
							</form>
						</div>
						<br>
						<div class="model-form-item">
							<input type="submit" form="myform" value="Place new menu" />
						</div>
					</div>
				</div>
			</div>
			<div class="menu-displayer">
				<%
				try {
					String url = "jdbc:mysql://localhost:3306/cafeteria";
					String username = "root";
					String password = "uplan";

					Class.forName("com.mysql.cj.jdbc.Driver");
					Connection connection = DriverManager.getConnection(url, username, password);
					Statement statement = connection.createStatement();
					Statement statement2 = connection.createStatement();

					String sql2 = "SELECT * FROM category ";

					ResultSet category = statement2.executeQuery(sql2);
					while (category.next()) {
						String cid = category.getString(1);
						String cin = category.getString(2);
						out.println("<div style='width: 100vw; color:#61116a'> <h2>" + cin + "</h2></div>");
						String sql = "SELECT * FROM victuals where category_id =" + cid;
						ResultSet result = statement.executeQuery(sql);
						while (result.next()) {

					String id = result.getString(1);
				%>
				<div class="menu-displayer-item">
					<div class="menus">
						<div class="menus-item">
							<img src="picture.jsp?id=<%=id%>" width="100" height="100">
						</div>
						<div id="menus-item-text" class="menus-item">
							<div class="menus-top">
								<div class="menus-top-item menus-top-title">
									<h2>
										<%
										out.print(result.getString(3));
										%>
									</h2>
								</div>
								<div class="menus-top-item">
									<%
									if (result.getString(5).equalsIgnoreCase("false")) {
									%>
									<span id="block" class="material-symbols-outlined">
										block </span>
									<%
									}
									%>

								</div>
								<div class="menus-top-item">
									<a
										href="edit_menu.jsp?imagePos=<%=result.getString(1)%>&&id=<%=result.getString(1)%>&&victualName=<%=result.getString(3)%>&&price=<%=result.getString(4)%>&&description=<%=result.getString(6)%>">
										<span id="update-menu" class="material-symbols-outlined">
											update </span>
									</a>
								</div>
							</div>
							<p>
								RM<%
							out.print(result.getString(4));
							%>
							</p>
							<p>
								<%
								out.print(result.getString(6));
								%>
							</p>
						</div>
					</div>
				</div>
				<%
				}
				result.close();
				}

				category.close();
				connection.close();
				} catch (Exception e) {
				out.println(e);
				}
				%>
			</div>
		</div>
		<div id="grossing-content" class="grossing-content">
			<div class="title-content">
				<h1>Profits</h1>
			</div>
			<div class="grossing-displayer">
				<div class="grossing-displayer-item grossing-1">
					<div class="grossing-overview-column">
						<div class="grossing-overview-column-item">
							<div class="grossing-overview">
								<div class="grossing-overview-item">
									<div class="grossing-top-tile">
										<div class="grossing-top-tile-item tst">
											<span class="material-symbols-outlined"> attach_money
											</span>
										</div>
										<div class="grossing-top-tile-item">Daily</div>
										<div class="grossing-top-tile-item">
											<%
											try {
												String url = "jdbc:mysql://localhost:3306/cafeteria";
												String username = "root";
												String password = "uplan";
												String sql = "SELECT SUM(TOTAL_PRICE) FROM `orders` WHERE PURCHASE_TIME = CURRENT_DATE;"; //where availability='true' 

												Class.forName("com.mysql.cj.jdbc.Driver");
												Connection connection = DriverManager.getConnection(url, username, password);
												Statement statement = connection.createStatement();

												ResultSet result = statement.executeQuery(sql);
												result.next();
												out.println("RM" + result.getString(1));
												result.close();
												connection.close();
											} catch (Exception exception) {
												out.println(exception);
											}
											%>
										</div>
									</div>
								</div>
								<div class="grossing-overview-item">
									<div class="grossing-top-tile">
										<div class="grossing-top-tile-item tst">
											<span class="material-symbols-outlined">
												account_balance_wallet </span>
										</div>
										<div class="grossing-top-tile-item">Weekly</div>
										<div class="grossing-top-tile-item">
											<%
											try {
												String url = "jdbc:mysql://localhost:3306/cafeteria";
												String username = "root";
												String password = "uplan";
												String sql = "SELECT SUM(TOTAL_PRICE) FROM ORDERS WHERE PURCHASE_TIME >= CURRENT_DATE AND PURCHASE_TIME <= CURRENT_DATE + 6"; //where availability='true' 
												Class.forName("com.mysql.cj.jdbc.Driver");
												Connection connection = DriverManager.getConnection(url, username, password);
												Statement statement = connection.createStatement();

												ResultSet result = statement.executeQuery(sql);
												result.next();
												out.println("RM" + result.getString(1));
												result.close();
												connection.close();
											} catch (Exception exception) {
												out.println(exception);
											}
											%>
										</div>
									</div>
								</div>
								<div class="grossing-overview-item">
									<div class="grossing-top-tile">
										<div class="grossing-top-tile-item tst">
											<span class="material-symbols-outlined"> monitoring </span>
										</div>
										<div class="grossing-top-tile-item">Monthly</div>
										<div class="grossing-top-tile-item">
											<%
											try {
												String url = "jdbc:mysql://localhost:3306/cafeteria";
												String username = "root";
												String password = "uplan";
												String sql = "SELECT SUM(TOTAL_PRICE) FROM ORDERS WHERE PURCHASE_TIME >= CURRENT_DATE AND PURCHASE_TIME  <= CURRENT_DATE + 29";
												Class.forName("com.mysql.cj.jdbc.Driver");
												Connection connection = DriverManager.getConnection(url, username, password);
												Statement statement = connection.createStatement();

												ResultSet result = statement.executeQuery(sql);
												result.next();
												out.println("RM" + result.getString(1));
												result.close();
												connection.close();
											} catch (Exception exception) {
												out.println(exception);
											}
											%>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="grossing-overview-column-item">
							<div class="grossing-overview-bottom">
								<div class="grossing-overview-bottom-item">
									<span class="material-symbols-outlined">
										local_fire_department </span>
								</div>
								<div class="grossing-overview-bottom-item" style="flex-grow: 1">
									<p>What a growth in sales!</p>
								</div>
								<div class="grossing-overview-bottom-item view-all-profit">
									<p>
										<a href="profit.jsp">View All Profit</a>
									</p>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="grossing-displayer-item grossing-2">
					<h3>today</h3>
					<table>
						<tr>
							<th>Victuals</th>
							<th>Total item</th>
							<th>Total sale</th>
						</tr>
						<%
						try {
							String url = "jdbc:mysql://localhost:3306/cafeteria";
							String username = "root";
							String password = "uplan";
							String sql = "SELECT VICTUALS.VICTUAL_NAME, ORDER_LINE.QUANTITY, ORDER_LINE.SUB_TOTAL FROM ORDER_LINE INNER JOIN VICTUALS ON ORDER_LINE.VICTUAL_ID = VICTUALS.VICTUAL_ID INNER JOIN ORDERS ON ORDER_LINE.ORDER_ID = ORDERS.ORDER_ID WHERE ORDERS.PURCHASE_TIME = CURRENT_DATE AND STATUS_ORDER = 'COMPLETED'";

							Class.forName("com.mysql.cj.jdbc.Driver");
							Connection connection = DriverManager.getConnection(url, username, password);
							Statement statement = connection.createStatement();

							ResultSet result = statement.executeQuery(sql);
							while (result.next()) {
								String id = result.getString(1);
						%>
						<tr>
							<td>
								<%
								out.print(result.getString(1));
								%>
							</td>
							<td>
								<%
								out.print(result.getString(2));
								%>
							</td>
							<td>
								<%
								out.print("RM" + result.getString(3));
								%>
							</td>
						</tr>

						<%
						}
						result.close();
						connection.close();
						} catch (Exception exception) {
						out.println(exception);
						}
						%>
					</table>
				</div>
			</div>
		</div>
		<div id="order-content" class="order-content">
			<div class="title-content">
				<h1>Orders</h1>
			</div>
			<div class="order-displayer">
				<table>
					<tr>
						<th>Name</th>
						<th>Victual ID</th>
						<th>Victual Name</th>
						<th>Total item</th>
						<th>Total sale</th>
						<th>Status</th>
						<th>Option</th>
					</tr>
					<%
					try {
						String url = "jdbc:mysql://localhost:3306/cafeteria";
						String username = "root";
						String password = "uplan";
						String sql = "SELECT CUSTOMER.NAME, ORDERS.ORDER_ID, VICTUALS.VICTUAL_NAME, QUANTITY, SUB_TOTAL, ORDERS.STATUS_ORDER FROM ORDER_LINE INNER JOIN ORDERS ON ORDERS.ORDER_ID = ORDER_LINE.ORDER_ID  INNER JOIN CUSTOMER ON CUSTOMER.CUSTOMER_ID = ORDERS.CUSTOMER_ID INNER JOIN VICTUALS ON ORDER_LINE.VICTUAL_ID = VICTUALS.VICTUAL_ID WHERE PURCHASE_TIME = CURRENT_DATE AND STATUS_ORDER = 'PROCESSING'";

						Class.forName("com.mysql.cj.jdbc.Driver");
						Connection connection = DriverManager.getConnection(url, username, password);
						Statement statement = connection.createStatement();

						ResultSet result = statement.executeQuery(sql);
						while (result.next()) {
							String id = result.getString(2);
					%>
					<tr>
						<td>
							<%
							out.print(result.getString(1));
							%>
						</td>
						<td>
							<%
							out.print(result.getString(2));
							%>
						</td>
						<td>
							<%
							out.print(result.getString(3));
							%>
						</td>
						<td>
							<%
							out.print("RM" + result.getString(4));
							%>
						</td>
						<td>
							<%
							out.print(result.getString(5));
							%>
						</td>
						<td>
							<%
							out.print(result.getString(6));
							%>
						</td>


						<td>
							<form action="processOrder" method="post">
								<input type="hidden" value="<%=id%>" name="order_id" />
								<button type="submit" id="process-button">
									<span class="material-symbols-outlined"> check </span>
								</button>
							</form>
						</td>
					</tr>
					<%
					}
					result.close();
					connection.close();
					} catch (Exception exception) {
					out.println(exception);
					}
					%>
				</table>
			</div>
		</div>

		<div id="action_button" class="action-button hide">
			<div class="action-button-item">
				<a href="#menu-content"> <span class="material-symbols-outlined">
						storefront </span></a>
			</div>
			<div class="action-button-item">
				<a href="#grossing-content"><span
					class="material-symbols-outlined"> account_balance_wallet </span></a>
			</div>
			<div class="action-button-item">
				<a href="#order-content"> <span
					class="material-symbols-outlined"> list_alt </span>
				</a>
			</div>
			<div class="action-button-item" onclick="scrollUp()">
				<span class="material-symbols-outlined"> arrow_upward </span>
			</div>
		</div>
		<div id="msg-container" style="display: none">
			<%
			boolean isCategoryAdded = Boolean.TRUE == request.getAttribute("isCategoryAdded");
			boolean isMenuAdded = Boolean.TRUE == request.getAttribute("isMenuAdded");

			if (isCategoryAdded) {
			%>
			<p>${categoryName}isadded</p>
			<script src="script/msg_container.js"></script>
			<%
			}
			%>


			<%
			if (isMenuAdded) {
			%>
			<p>${victualName}isadded</p>
			<script src="script/msg_container.js"></script>
			<%
			}
			%>

		</div>
		<script src="script/modal_box.js"></script>
		<script src="script/menu_pic_upload.js"></script>
		<script src="script/action_button.js"></script>
	</div>
</body>
</html>
