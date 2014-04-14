<?php

include_once dirname(__FILE__) . '/config.php';

if ( isset( $_GET[ 'comp' ] ) ) { $component = $_GET[ 'comp' ]; } else { echo "Component not specified."; exit(); }
if ($component == "try"){ include_once ROOT."/try.php"; exit(); }
if ( isset( $_GET[ 'subcomp' ] ) ) { $subcomp = $_GET[ 'subcomp' ]; } else { echo "Sub-component not specified."; exit(); }

// CONNECTOR COMPONENT
if ($component == "connector"){
	$connector = new connector();
	if ( $subcomp == "send" ){ $connector->messageSender(); }
	else if ( $subcomp == "retr" ){ $connector->messageRetriever(); }
	else if ( $subcomp == "connalive" ){ $connector->connectionAlive(); } //ok
	else if ( $subcomp == "login" ){ $connector->userLogin(); } //ok
	else if ( $subcomp == "sql" ){ $connector->sql(); }
	else { echo "[CONNECTOR] Unknown interface."; exit(); }
	exit();
}
// SENDER COMPONENT
else if ($component == "sender"){
	$sender = new sender();
	if ( $subcomp == "sendmsg" ){ $sender->sendmsg(); }
	else if ( $subcomp == "userdata" ){ $sender->userdata(); }
	else { echo "[SENDER] Unknown interface."; exit(); }
}
// LISTENER COMPONENT
else if ($component == "listener"){
	$listener = new listener();
	if ( $subcomp == "retr" ){ $listener->retrieve(); }
	else { echo "[LISTENER] Unknown interface."; exit(); }
}
// AUTHENTICATOR COMPONENT
else if ($component == "auth"){
	$auth = new authenticator(); 
	if ( $subcomp == "usrform" ){ $auth->userForm(); } //ok
	else if ( $subcomp == "sesstart" ){ $auth->sessionStarter(); } //ok
	else if ( $subcomp == "sesreq" ){ $auth->sessionReporter(); } //ok
	else if ( $subcomp == "sesdestroy" ){ $auth->sessionDestroy(); } //ok
	else { echo "[AUTHENTICATOR] Unknown interface."; exit(); }
}
else {
	echo "Unknown component..";
	exit();
}
exit();