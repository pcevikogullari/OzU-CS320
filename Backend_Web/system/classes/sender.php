<?php
class sender {

	public function sendmsg(){
		if ( isset($_GET['msg']) ){
			$msg = urldecode($_GET['msg']);

			$url = DOMAIN.'/system/call.php?comp=auth&subcomp=sesreq';
			$curl = curl_init($url);
			$res = curl_exec($curl);
			curl_close($curl);

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