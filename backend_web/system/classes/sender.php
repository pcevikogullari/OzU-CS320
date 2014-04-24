<?php
class sender {

	public function sendmsg(){
		if ( isset($_GET['crid']) && isset($_GET['msg']) ){
			// retrieve chatroom id
			$crid = $_GET['crid'];
			// retrieve message
			$msg = $_GET['msg'];//url encoded
			if (isset($_GET['uid'])){ $usrid = $_GET['uid']; }
			else{
				// retrieve logged in user id by asking to the authenticator
				$url = DOMAIN.'/system/call.php?comp=auth&subcomp=sesreq';
				$usrid = request($url);
			}
			// send these data to connector
			$url_send = DOMAIN."/system/call.php?comp=connector&subcomp=send&userid=".$usrid."&crid=".$crid."&msg=".$msg;
			echo request($url_send);
		}
		else { echo "[SENDER-SENDMSG] Missing data..."; exit(); }
		exit();
	}
	public function userdata(){
		if ( isset($_GET['msg']) ){
			
		}
		else { echo "[SENDER-USERDATA] Missing data..."; exit(); }
		exit();
	}
	
}