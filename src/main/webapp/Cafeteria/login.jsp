<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<head>
<meta charset="ISO-8859-1">
<title></title>
<link rel="stylesheet" href="style/login.css" />
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
</head>
<body>
	<div class="login-container">
		<div class="login-container-item left-container">
			<div class="login-part">
				<div class="login-part-item">
					<h1>Hello</h1>
				</div>
				<form action="login" method="post" id="loginForm">
					<div class="login-part-item">
						<input type="text" placeholder="USERNAME" name="username" /> <br />
						<br /> <input type="password" placeholder="PASSWORD"
							name="password" />
					</div>
				</form>
				<div class="login-part-item">
					<input type="submit" placeholder="LOGIN" form="loginForm" />
				</div>
			</div>
		</div>
		<div class="login-container-item right-container">
			<div class="login-part login-part-second">
				<div class="login-part-item">
					<h1>Welcome Back!</h1>
				</div>
				<div class="login-part-item">Ready your day with happy smile
					at your face! :)</div>
			</div>
		</div>
	</div>
	<div id="msg-container" style="display: none">
		<p>wrong username/password or both</p>
		<%
		boolean isError = Boolean.TRUE == request.getAttribute("isError");
		

		if (isError) {
		%>
		<script>
			setTimeout(()=> {
				const msgContainer = document.getElementById("msg-container");
				msgContainer.style.display = "block";
			}, 1000);
			
			setTimeout(()=> {
				const msgContainer = document.getElementById("msg-container");
				msgContainer.style.display = "none";
			}, 3000);
		</script>
		<%
		}
		%>
	</div>
</body>
</html>
