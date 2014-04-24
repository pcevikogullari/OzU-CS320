<?php
class authenticator {
	
	public function sessionReporter(){
		if (isset($_SESSION['userid'])){ echo $_SESSION['userid']; }
		else { echo "0"; }
	}
	public function sessionStarter(){
		if ( isset($_GET['usrid']) ){ 
			$_SESSION['userid'] = $_GET['usrid'];
			echo $_SESSION['userid'];
		}
		else { echo "[AUTH-SESSIONSTARTER] Missing data..."; exit(); }
		exit();
	}
	public function sessionDestroy(){
		unset($_SESSION['userid']);
		session_destroy();
	}
	public function userForm(){
		if ( isset($_GET['email']) && isset($_GET['pass']) ){
			// send IUserLogin interface to connector
			$url = DOMAIN.'/system/call.php?comp=connector&subcomp=login&email='.$_GET['email'].'&pass='.$_GET['pass'];
			$res = request($url);
			echo $res; //return
		}
		else { echo "[AUTH-SESSIONSTARTER] Missing data..."; exit(); }
		exit();
	}

}