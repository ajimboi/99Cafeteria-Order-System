var modal = document.getElementById("menuModal");
var modalCat = document.getElementById("categoryModal");
//var modalEdit = document.getElementById("updateMenuModal");
var btn = document.getElementById("add_menu");
var btnCategory = document.getElementById("category_option");
//var btnEditMenu = document.getElementById("update-menu");
 //var pic = document.getElementById("thePic");

btn.onclick = function () {
  modal.style.display = "block";
};

btnCategory.onclick = function () {
	modalCat.style.display = "block";
}

/*
function updateMenusFunc(formPos, option) {
	
	var modalEdit = document.getElementsByClassName("updateMenus")[formPos];
	if(option == 'open'){
		modalEdit.style.display = "block";
	}else if(option == 'close'){
		modalEdit.style.display = "none";
	}
  
}
*/

/*
btnEditMenu.onclick = function () {
	modalEdit.style.display = "block";
}
*/

window.onclick = function (event) {
  if (event.target == modal) {
    modal.style.display = "none";
   // pic.src = '#';
  }
  
  if (event.target == modalCat) {
    modalCat.style.display = "none";
   // pic.src = '#';
  }
  
  /*
  if(event.target == modalEdit){
	modalEdit.style.display = "none";
}*/
  
};
