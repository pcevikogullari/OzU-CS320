<?php

session_name( 'cetinapp' );
if(session_id() == '') {
    session_start();
}

$domain = "http://cevikogullari.com";
//$domain = "http://localhost:8888";

function request($url){
	$session_name = session_name();
	$session_id = session_id();
	session_write_close();
	$curl = curl_init();
	curl_setopt($curl, CURLOPT_URL, $url);
	curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
	curl_setopt($curl, CURLOPT_COOKIE, $session_name.'='.$session_id);
	$res = curl_exec($curl);
	curl_close($curl);
	@session_id($session_id);
	@session_start();
	return $res;
}