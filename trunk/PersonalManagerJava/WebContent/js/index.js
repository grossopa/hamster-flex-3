function submitBtn_clickHandler() {
	var params = {
		'userKey' : $('login_key_input').value,
		'message' : $('message_ta').innerHTML
	};
	
	var params2 = 'userKey=' + document.getElementById('login_key_input').value 
	+ '&message=' + encodeURIComponent(document.getElementById('message_ta').value);
	//alert(params2);
	readRemoteUrl('updateStatus', updateStatusResultHandler, null, params2, 'POST');
}

function updateStatusResultHandler(data) {
	alert(data);
}