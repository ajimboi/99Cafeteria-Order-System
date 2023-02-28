<!DOCTYPE html>
<html>
<head>
<title>User Sign/Login</title>
<!--Required-->
<link rel="stylesheet" href="styles/global.css" />
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+Display&
    family=Open+Sans&family=Roboto&family=Work+Sans&display=swap"
	rel="stylesheet" />
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="stylesheet" href="style/user-sign-login.css" />
</head>
<body>
	<div class='header-auto'>
		<div class='header-auto-item'>
			<h1>Welcome to 99Cafeteria!</h1>
		</div>
		<div class='header-auto-item'>
			<img src="images/brand_logo.jpeg" width="130" height="80">
		</div>
	</div>
	<section class="body-container">
		<section class="body-container-outer">
			<section class="body-row">
				<section class="body-row-item"
					style="flex-basis: 300px; flex-grow: 4">
					<div id="bothDiv">
						<section class="body-row-item-column">
							<section class="body-row-item-column-item" style="height: 50vh">
								<div id="sign-up">
									<h1>Sign Up</h1>
									<p>99Cafeteria is much better when you have an account.</p>
									<br />
									<p>Get yourself one.</p>
								</div>

								<div id="login">
									<h1>Log in</h1>
									<p>Welcome to 99Cafeteria.</p>
								</div>
							</section>
							<section class="body-row-item-column-item" style="height: 14.5vh">
								<p>Have an account? Log in now.</p>
								<button id="buttonText" onclick="toggleBetween()">
									Login</button>
							</section>
						</section>
					</div>
				</section>
				<section class="body-row-item"
					style="flex-basis: 500px; flex-grow: 7; background-color: #61116a">
					<div id="sign-up-form">
						<form action="signup" method='post'>
							<p>USERNAME</p>
							<input name="username" type="text" />
							<p>FULLNAME</p>
							<input name="fullname" type="text" />
							<p>TELEPHONE NO</p>
							<input type="tel" name='phone_number' />
							<p>PASSWORD</p>
							<input name="password" type="password" />
							<p>REPEAT PASSWORD</p>
							<input name="retype_password" type="password" /> <br />
							<button type="submit" name="sign_up">Sign Up</button>
						</form>
					</div>
					<div id="login-form">
						<form action="login" method="post">
							<p>USERNAME</p>
							<input name="username" type="text" />
							<p>PASSWORD</p>
							<input name="password" type="password" /> <br />
							<button type="submit" name="login">Login</button>
						</form>
					</div>
				</section>
			</section>
		</section>
	</section>
	<div id="msg-container" style="display: none">

		<%
		boolean isError = Boolean.TRUE == request.getAttribute("isError");
		boolean isAccountAdded = Boolean.TRUE == request.getAttribute("isAccountAdded");

		if (isError) {
		%>
		<p>wrong username/password or both</p>
		<script src="script/msg_container.js"></script>
		<%
		}
		%>

		<%
		if (isAccountAdded) {
		%>
		<p>account created!</p>
		<script src="script/msg_container.js"></script>
		<%
		}
		%>

	</div>
	<script src="script/user-sign-login.js"></script>
</body>
</html>
