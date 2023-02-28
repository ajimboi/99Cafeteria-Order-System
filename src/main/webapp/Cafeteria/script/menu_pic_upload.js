/**
 * 
 */

var currentFile = document.getElementById("imgInp");
var pic = document.getElementById("thePic");
currentFile.onchange = () => {
	const [file] = currentFile.files
	if (file) {
		pic.src = URL.createObjectURL(file);
	}
}

/*
var imagePosition = 0;

function updateImage(imagePos) {
	imagePosition = imagePos;
	console.log(imagePos);

	var currentFile = document.getElementsByClassName("the-image-display")[imagePos];
	console.log(currentFile);
	var imageToUpdate = document.getElementsByClassName("image-to-change")[imagePos];
	currentFile.onchange = () => {
		const [file] = currentFile.files
		if (file) {
			imageToUpdate.src = URL.createObjectURL(file);
		}
	}
}
*/

