$(document).ready(function(){

	$('.submitbutton').click(function(){
		var email = $('.email').val();
		var pass = $('.pass').val();

		$.ajax({
			type: "POST",
			url: "/web/php/login.php",
			data: { 'email':email, 'pass':pass },
			success: function(msg){
				if (msg == "0"){ alert("Incorrect email/password."); }
				else{

					$.ajax({
						type: "POST",
						url: "/web/php/session.php",
						data: { 'userid':msg },
						success: function(msg){
							if (msg == "1"){
								window.location.replace("web/mainpage.php");
							}
							else{ alert("Something went wrong while starting session."); }
						}
					});
					
				}
			}
		});
	});
});