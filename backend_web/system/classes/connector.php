<?php
class connector {
	
	private $pdo;

	public function connector(){
		try { $this->pdo = new PDO("mysql:host=".DB_HOST.";dbname=".DB_NAME.";charset=utf8",DB_USER,DB_PASSWORD,array(PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES 'utf8'")); } 
		catch (PDOException $e) { echo "[CONNECTOR] Cannot connect to database"; exit(); }
	}

	public function messageSender(){
		if ( isset($_GET['userid']) && isset($_GET['crid']) && isset($_GET['msg']) ){
			// retrieve data
			$userid = $_GET['userid'];
			$crid = $_GET['crid'];
			error_log("dec:".$_GET['msg']);
			$msg = urldecode($_GET['msg']);
			// send to database
			$query = $this->pdo->prepare("INSERT INTO ".TABLE_USER_MESSAGE." VALUES (:id, :send_usr_id, :chatroom_id, :message, :date)");
			$query->execute(array(':id'=>'', ':send_usr_id'=>$userid, ':chatroom_id'=>$crid, ':message'=>$msg, ':date'=>time()));
			$sentid = $this->pdo->lastInsertId();
			// update last sent message
			$query = $this->pdo->prepare("UPDATE ".TABLE_CHATROOM." SET `last_msg_id`=:sentid WHERE `id`=:crid ");
			$query->execute(array(':sentid'=>$sentid, ':crid'=>$crid));
			echo $sentid;
		}
		else { echo "[CONNECTOR-SENDER] Missing data..."; exit(); }
		exit();
	}

	public function messageRetriever(){
		if ( isset($_GET['crid']) && isset($_GET['lastrecid']) ){
			$crid = sanitize($_GET['crid']);
			$lastrecid = sanitize($_GET['lastrecid']);

			$query = $this->pdo->prepare("SELECT * FROM ".TABLE_USER_MESSAGE." WHERE chatroom_id=:crid && id>:lastrecid ORDER BY date ASC");
			$query->bindValue(':lastrecid', (int)$lastrecid, PDO::PARAM_INT);
			$query->bindValue(':crid', $crid);
			$query->execute();
			$results = $query->fetchAll(PDO::FETCH_ASSOC);
			echo json_encode($results);
		}
		else { echo "[CONNECTOR-RETRIEVER] Missing data..."; exit(); }
		exit();
	}

	public function connectionAlive(){ return 1; }

	public function userLogin(){
		if ( (isset($_GET['email'])) && (isset($_GET['pass'])) ){
			$email = urldecode($_GET['email']);
			$pass = urldecode($_GET['pass']);

			$query = $this->pdo->prepare("SELECT * FROM ".TABLE_USER." WHERE mail=:email AND pass=:pass LIMIT 1");
			$query->execute(array(':email'=>$email, ':pass'=>$pass));
			$results = $query->fetchAll(PDO::FETCH_ASSOC);

			if (count($results) > 0) {  echo $results[0]['id']; }
			else{ echo "0"; }
		}
		else { echo "[CONNECTOR-USERLOGIN] Missing data..."; exit(); }
		exit();
	}

	public function sql(){
		if ( isset($_GET['sql']) ){
			// Unpack SQL JSON
			$sql = "";
			$sql_json = urldecode($_GET['sql']);
			$sql_arr = json_decode($sql_json);
			foreach($sql_arr as $sa){
				$sql .= $sa." ";
			}
			$query = $this->pdo->prepare($sql);
			$query->execute();
			$results = $query->fetchAll(PDO::FETCH_ASSOC);
			echo json_encode($results);
		}
		else { echo "[CONNECTOR-SQL] Missing data..."; exit(); }
		exit();
	}

}