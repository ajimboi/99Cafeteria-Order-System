var myID = document.getElementById("action_button");

var myScrollFunc = function () {
  var y = window.scrollY;
  console.log(y);
  if (y >= 50) {
    myID.className = "action-button show";
    myID.style.display = "block";
  } else {
    myID.className = "action-button hide";
    myID.style.display = "none";
  }
};

function scrollUp() {
  document.body.scrollTop = 0;
  document.documentElement.scrollTop = 0;
}

window.addEventListener("scroll", myScrollFunc);
