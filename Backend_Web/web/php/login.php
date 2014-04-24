<?php

include_once 'includes.php';

if ( isset($_POST['email']) && isset($_POST['pass']) ){
	$email = $_GET['email'];
	$pass = $_GET['pass'];

	$url = DOMAIN."/system/call.php?comp=auth&subcomp=usrform&email=".urlencode($_POST['email'])."&pass=".urlencode($_POST['pass']);
	$result = request($url);

	echo $result;

}