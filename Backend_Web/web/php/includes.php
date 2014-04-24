<?php

session_name( 'cetinapp' );
if(session_id() == '') {
	session_start();
}

define( "TABLE_CHATROOM", 'chatroom' );
define( "TABLE_USER", 'user' );
define( "TABLE_USER_CHATROOM", 'user_chatroom' );
define( "TABLE_USER_FRIEND", 'user_friend' );
define( "TABLE_USER_MESSAGE", 'user_message' );

define( "DOMAIN", "http://localhost:8888" );
//define( "DOMAIN", "http://cevikogullari.com" );


// performs an http request to the backend
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

// sends sql query to connector component
function querySQL($sql){
	$sql_arr = explode(" ", $sql);
	$sql_json = json_encode($sql_arr);
	$url = DOMAIN."/system/call.php?comp=connector&subcomp=sql&sql=".urlencode($sql_json);
	$chatrooms = request($url);
	$crarr = json_decode($chatrooms, true);
	return $crarr;
}

function sanitize ($str) {
	return stripslashes(filter_var($str , FILTER_SANITIZE_MAGIC_QUOTES ));
}