$(document).ready(function(){
	
	var lastReceivedID = 0;

	scrollBottom();
	setInterval(function() {
		lastReceivedID = getLastReceived();
		console.log("lastReceived : "+lastReceivedID);

		listenText(lastReceivedID);

		scrollBottom();
	}, 3000);

	// send button clicked
	$('#msgBoxBTN').click(function(){
		sendText();
	});
	// enter button clicked
	$('#msgBoxTA').keypress(function(event) {
		if (event.which == 13) {
			event.preventDefault();
			sendText();
		}
	});

});

function refresh(){

}

function getLastReceived(){
	var lr = $('li.msg.ok:last-child').attr('id');
	if (lr == undefined){
		return 0;
	}
	return lr;
}

function sendText(){
	var tb = $('#msgBoxTA');
	var msg = tb.val();
	var crid = $('.msgText').attr('id');
	var randnum = Math.floor((Math.random()*100000)+1);
	tb.val("");
	appendmsg(msg, "fromyou", randnum, 0);
	console.log("/system/call.php?comp=sender&subcomp=sendmsg&crid="+crid+"&msg="+encodeURIComponent(msg));
	$.ajax({
		type: "GET",
		url: "/system/call.php?comp=sender&subcomp=sendmsg&crid="+crid+"&msg="+encodeURIComponent(msg),
		success: function(msg){
			$('#img'+randnum).remove();
			$('#del'+randnum).removeClass('notsent');
			$('#del'+randnum).addClass('ok');
			$('#del'+randnum).attr('id', msg);

			console.log("OK: "+msg);
		}
	});
}

function listenText(lastReceivedID){
	var crid = $('.msgText').attr('id');
	
	var usrid = 0;
	$.ajax({
		type: "GET",
		url: "/system/call.php?comp=auth&subcomp=sesreq",
		success: function(msg){
			usrid = msg;
		}
	});

	$.ajax({
		type: "GET",
		url: "/system/call.php?comp=listener&subcomp=retr&crid="+crid+"&lastrecid="+lastReceivedID,
		success: function(rtn){
			var msgs = jQuery.parseJSON(rtn);
			$(msgs).each(function(i){
				var msg = msgs[i];
				console.log(msg);
				if (msg.send_usr_id == usrid){ appendmsg(msg.message, "fromyou", -1, msg.id); }
				else{ appendmsg(msg.message, "fromother", -1, msg.id); }
				scrollBottom();
			});
		}
	});
}



function appendmsg( msg, from, randnum, id ){
	if (randnum == -1){ var appendhtml = "<li class='msg "+from+" ok' id='"+id+"'> <span class='msgtxt'> "+msg+" </span></li>";	}
	else{ var appendhtml = "<li class='msg "+from+" notsent' id='del"+randnum+"'> <img class='loader' style='width:15px;height:15px;' id='img"+randnum+"'src='/web/img/loader.gif'> <span class='msgtxt'> "+msg+" </span></li>"; }
	$('.msgText ul.messages').append(appendhtml);
	scrollBottom();
}

function scrollBottom(){
	var elem = $('.msgText');
	var scheight = elem.prop('scrollHeight');
	elem.scrollTop(scheight);
	//elem.animate({ scrollTop:scheight },500);
}