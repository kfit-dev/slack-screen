function ScreenController() {
	// initiate.
	this.currentWindow = null;
	this.newWindow = null;
}

ScreenController.prototype.openNewScreen = function(urlToOpen, cb) {
	this.newWindow = window.open(urlToOpen);
	cb();
}

ScreenController.prototype.closePreviousScreen = function(urlToOpen) {
	if (this.currentWindow) {
		this.currentWindow.close();
	}
	this.currentWindow = this.newWindow;
	this.newWindow = null;
}

export default ScreenController;
