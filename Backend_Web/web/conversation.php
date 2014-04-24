<?php
include_once "php/includes.php";

if (!isset($_GET['id'])){ 
	header('Location: /web/mainpage.php');
	exit();
}
$conv = querySQL("SELECT * FROM ".TABLE_CHATROOM." WHERE id = ".sanitize($_GET['id'])." LIMIT 1");
?>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<title><?php echo $conv[0]['name']." | CetinApp"; ?></title>

	<link href="/web/css/bootstrap.min.css" rel="stylesheet">
	<link href="/web/css/signin.css" rel="stylesheet">
	<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
	<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
	<script src="/web/js/bootstrap.min.js"></script>
	<script src="/web/js/script.js"></script>
	<script src="/web/js/msgroom.js"></script>

	<style>
	body {
		padding-top: 50px;
	}
	.starter-template {
		padding: 40px 15px;
		text-align: center;
	}
	.msgfield {
		position: absolute;
		width: 100%;
	}
	.msgfield.msgBox {
		height: 10%;
		bottom: 0;
		left: 0;
		padding: 0;
	}
	.msgfield.msgText {
		height: 90%;
		max-height: 90%;
		overflow-x: hidden;
		overflow-y: scroll;
		top: 0;
		left: 0;
		padding: 20px;
		padding-top: 70px;
	}
	#msgBoxTA{
		width: 90%;
		height: 100%;
		margin: 0;
		padding: 5px;
		border: none;
		outline: none;
		float: left;
		color: gray;
	}
	#msgBoxBTN{
		width: 10%;
		height: 100%;
		margin: 0;
		border: none;
		outline: none;
		float: left;
		border-radius: 0;
	}
	span.msgtxt {
		padding: 5px;
		border-radius: 5px;
	}
	ul.messages {
	}
	li.msg {
		width: 100%;
		margin-bottom: 20px;
	}
	/* msg from you */
	li.msg.fromyou {
		text-align: right;
	}
	li.msg.fromyou span.msgtxt {
		background-color: lightgray;
	}
	/* msg from other */
	li.msg.fromother {
		text-align: left;
	}
	li.msg.fromother span.msgtxt {
		background-color: lightblue;
	}
	</style>
</head>

<body>

	<div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
					<span class="sr-only">Toggle navigation</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="/web/mainpage.php">CetinApp</a>
			</div>
			<div class="collapse navbar-collapse">
				<ul class="nav navbar-nav">
					<li><a href="#">Add Participant</a></li>
				</ul>
			</div>
		</div>
	</div>

	<!-- Messages -->
	<div class="msgfield msgText" id="<?php echo $conv[0]['id']; ?>">
		
		<ul class="list-unstyled messages">
			
		</ul>


	</div>
	
	<!-- Text area -->
	<div class="msgfield msgBox">
		<textarea id="msgBoxTA" placeholder="Enter text..."></textarea>
		<button type="button" class="btn btn-info" id="msgBoxBTN">
			<span class="glyphicon glyphicon-send"></span>
		</button>
		<div class="clearfix"></div>
	</div>

</body>
</html>
