<?php
function request($url){
	$session_name = session_name();
	$session_id = session_id();
	session_write_close();
	// init the request
	$curl = curl_init();
	curl_setopt($curl, CURLOPT_URL, $url);
	curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
	curl_setopt($curl, CURLOPT_COOKIE, $session_name.'='.$session_id);
	$res = curl_exec($curl);
	curl_close($curl);
	// start session
	@session_id($session_id);
	@session_start();
	return $res;
}

function sanitize ($str) {
	return stripslashes(filter_var($str , FILTER_SANITIZE_MAGIC_QUOTES ));
}
?>