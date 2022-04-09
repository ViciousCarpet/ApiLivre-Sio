<?php
class Note {
    // Objet PDO servant à la connexion à la base
	private $pdo;

	// Connexion à la base de données
	public function __construct() {
		$config = parse_ini_file("config.ini");
		try {
			$this->pdo = new \PDO("mysql:host=".$config["host"].";dbname=".$config["database"].";charset=utf8", $config["user"], $config["password"]);
		} catch(Exception $e) {
			echo $e->getMessage();
		}
	}
	public function getNoteComm($unLivre){		// Renvoie les notes puis tous les commentaires
		try{
			$sql = "Call SelectComNote(:id)";	
			
			$req = $this->pdo->prepare($sql);
			$req->bindParam(":id",$unLivre,PDO::PARAM_INT);
			$req->execute();
			return $req->fetchAll(PDO::FETCH_ASSOC);
		}
		catch(PDOException $e){
			echo "Problème de communication avec la base de données!";
		}
	}

	public function setNoteComm($unParent,$unLivre,$uneNote,$unCommentaire){	//Insère une note et un commentaire à la date d'aujourd'hui
		try{
			$this->pdo->beginTransaction();
			$sql = "INSERT INTO Noter VALUES(:unParent,:unLivre,NOW(),:uneNote,:unCommentaire)";
			$req= $this->pdo->prepare($sql);
			$req->bindParam(":unParent",$unParent,PDO::PARAM_INT);
			$req->bindParam(":unLivre",$unLivre,PDO::PARAM_INT);
			$req->bindParam(":uneNote",$uneNote,PDO::PARAM_INT);
			$req->bindParam(":unCommentaire",$unCommentaire,PDO::PARAM_STR);
			$req->execute();
			$this->pdo->commit();
		}
		catch(PDOException $e){
			echo "Problème de connexion à la base de données!";
			$this->pdo->rollback();
		}
		
	}
}
?>