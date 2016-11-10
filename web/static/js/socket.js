// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "web/static/js/app.js".

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/my_app/endpoint.ex":
import {Socket} from "phoenix"
import ScreenController from "./screen-controller.js"

let socket = new Socket("/socket", {params: {token: window.userToken}})
let chan;
// 5 places for messages...
let messageArr = ['', '', '', '', ''];

function renderMessagesArr(incomingMsg) {
	messageArr.shift();
	messageArr.push(incomingMsg);
	let htmlRenderedLi = messageArr.map(function(item) {
		return "<li class='messageLiItem'>"+ item+ "<li>";
	}).join('');
	document.querySelector('.channelIncomingMessages')
		.innerHTML = htmlRenderedLi;
}

function setStatusText(status) {
	if (status === 'on') {
		statusText.innerHTML = "it's on";
		statusText.style.color = "green";
		statusText.style.fontWeight = "800";
	} else {
		statusText.innerHTML = "offline";
		statusText.style.color = "red";
		statusText.style.fontWeight = "800";
	}
}

function connectChannel() {
	socket.connect()

	chan = socket.channel("screen:main", {})
	chan.join()
	 	.receive("ignore", () => console.log("auth error"))
	  	.receive("ok", resp => { 
	  		//console.log("Joined success", resp)
	  		renderMessagesArr("Joined screen:main successfully.");
			setStatusText('on');
	  	})
	  	.receive("timeout", () => console.log("Conn interupt"))
	  	.receive("error", resp => { 
	  		// console.log("Unable to join", resp)
	  		renderMessagesArr("Unable to join.");
	  		setStatusText('off');
	  	})

	chan.onError(e => {
		console.log("something went wrong. ", e)
		  	renderMessagesArr("Something went wrong.");
			setStatusText('off');
	})

	chan.onClose(e => console.log("channel closed", e))

	let sc = new ScreenController();
	chan.on("new:screen", message => {
		console.log('Got a change screen cmd from the Phoenix Screen Channel!', message);
		renderMessagesArr("Got a change screen cmd from the Phoenix Screen Channel! -> "+ message.url);
		sc.openNewScreen(message.url, () => {
			sc.closePreviousScreen();
		});
	});

}

let statusText = document.querySelector('.statusText');
setStatusText('off');

let actionBtn = document.querySelector('.actionBtn');

actionBtn.addEventListener('click', () => {

	if (actionBtn.innerHTML === "ON") {
		renderMessagesArr('Connecting with channels...');
		connectChannel();
		actionBtn.innerHTML = "OFF";
		actionBtn.className = "btn btn-warning actionBtn";
		setStatusText('on');
	} else {
		renderMessagesArr('Closing connection with channels...');
		chan.leave();
		actionBtn.innerHTML = "ON";
		actionBtn.className = "btn btn-success actionBtn";
		setStatusText('off');
	}

});

// Now that you are connected, you can join channels with a topic:

export default socket;
