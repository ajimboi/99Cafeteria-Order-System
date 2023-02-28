var profit = document.getElementById("accumulation-profit");
var menu_sales = document.getElementById("menu-sales");
var title = document.getElementById("title-display");

function display(selected) {
  if (selected == "profit") {
    profit.style.display = "block";
    menu_sales.style.display = "none";
    title.innerText = "Profit in last 7 days";
    document.getElementsByClassName("button-option-item")[0].style.color =
      "fuchsia";
    document.getElementsByClassName("button-option-item")[1].style.color =
      "black";
  } else if (selected == "menu_sales") {
    menu_sales.style.display = "block";
    profit.style.display = "none";
    title.innerText = "Menu sold in a month";
    document.getElementsByClassName("button-option-item")[0].style.color =
      "black";
    document.getElementsByClassName("button-option-item")[1].style.color =
      "fuchsia";
  }
}
