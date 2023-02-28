function toggleBetween() {
	var loginText = document.getElementById("login");
	var formLogin = document.getElementById("login-form");
	var signText = document.getElementById("sign-up");
	var formSign = document.getElementById("sign-up-form");
	var buttonText = document.getElementById("buttonText");
	var bothDiv = document.getElementById("bothDiv");

	bothDiv.classList.remove("animation");
	window.requestAnimationFrame(function() {
		bothDiv.classList.add("animation");
	});

	if (
		(loginText.style.display === "none" || loginText.style.display === "") &&
		(formLogin.style.display === "none" || formLogin.style.display === "")
	) {
		loginText.style.display = "block";
		bothDiv.style.backgroundColor = "whitesmoke";
		formLogin.style.display = "block";
		signText.style.display = "none";
		formSign.style.display = "none";
		buttonText.innerHTML = "Sign Up";
	} else {
		loginText.style.display = "none";
		formLogin.style.display = "none";
		bothDiv.style.backgroundColor = "whitesmoke"; //change for body-row-item

		if (
			signText.style.display === "none" &&
			formSign.style.display === "none"
		) {
			signText.style.display = "block";

			formSign.style.display = "block";
			buttonText.innerHTML = "Login";
		}
	}
}
