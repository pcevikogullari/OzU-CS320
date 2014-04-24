<?php
include_once "php/includes.php";
?>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<title>CetinApp</title>

	<link href="/web/css/bootstrap.min.css" rel="stylesheet">
	<link href="/web/css/signin.css" rel="stylesheet">
	<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
	<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
	<script src="/web/js/bootstrap.min.js"></script>
	<script src="/web/js/script.js"></script>

	<style>
	body {
		padding-top: 50px;
	}
	.starter-template {
		padding: 40px 15px;
		text-align: center;
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
				<a class="navbar-brand" href="#">CetinApp</a>
			</div>
			<div class="collapse navbar-collapse">
				<ul class="nav navbar-nav">
					<li class="active"><a href="#">Home</a></li>
					<li><a href="#about">New Chat</a></li>
				</ul>
			</div><!--/.nav-collapse -->
		</div>
	</div>

	<div class="container">

		<div class="col-xs-12" style='margin-top:30px;'>
			<h2>Conversations</h2>
			<table class="table table-hover">
				<?php
				// sends sql query to connector component
				$crarr = querySQL("SELECT * FROM ".TABLE_CHATROOM);
				foreach($crarr as $cr){
					echo "<tr class='chatroomlink'><td><a href='/web/conversation.php?id=".$cr['id']."'>".$cr['name']."</a></td></tr>";
				}
				?>
			</table>
		</div>

	</div>
</body>
</html>
