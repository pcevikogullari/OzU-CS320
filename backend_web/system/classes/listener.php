<?php
class listener {
	
	public function retrieve(){
		if ( isset($_GET['crid']) && isset($_GET['lastrecid']) ){
			// receive chatroom id
			$crid = $_GET['crid'];
			// receive last received message id
			$lastrecid = $_GET['lastrecid'];
			// send data to connector
			$url = DOMAIN."/system/call.php?comp=connector&subcomp=retr&crid=".$crid."&lastrecid=".$lastrecid;
			echo request($url);
		}
		else { echo "[LISTENER-RETRIEVE] Missing data..."; exit(); }
		exit();
	}

}