<?php
class connector {
	
	private $pdo;

	public function connector(){
		try { $this->pdo = new PDO("mysql:host=".DB_HOST.";dbname=".DB_NAME.";charset=utf8",DB_USER,DB_PASSWORD,array(PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES 'utf8'")); } 
		catch (PDOException $e) { echo "[CONNECTOR] Cannot connect to database"; exit(); }
	}

	public function messageSender(){
		if ( isset($_GET['userid']) && isset($_GET['crid']) && isset($_GET['msg']) ){
		}
		else { echo "[CONNECTOR-SENDER] Missing data..."; exit(); }
		exit();
	}

	public function messageRetriever(){
		if ( isset($_GET['crid']) ){
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
			$sql = urldecode($_GET['sql']);
		}
		else { echo "[CONNECTOR-SQL] Missing data..."; exit(); }
		exit();
	}

}