<?php
class Parents {
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

	public function connect_verif($id, $mdp) {
		$mdp = hash("sha256", "*//".$mdp."//*");
		$sql = "SELECT Count(id), id FROM `Parent` WHERE identifiant = ? && motDePasse = ?";
		
		$req = $this->pdo->prepare($sql);
		$req->bindParam(1, $id);
		$req->bindParam(2, $mdp);
		$req->execute();
		return $req->fetch(PDO::FETCH_ASSOC);
	}

	public function inscription($id, $mdp, $nomEnf, $prenomEnf, $classe){
		try{
			$this->pdo->beginTransaction();
			$mdp= hash("sha256", "*//".$mdp."//*");
			$sql = "CALL InscrireParent(:idparent,:mdpparent,:nomenfant,:prenomenfant,:classe);";
			
			$req = $this->pdo->prepare($sql);
			$req->bindParam(":idparent",$id,PDO::PARAM_STR);
			$req->bindParam(":mdpparent",$mdp,PDO::PARAM_STR);
			$req->bindParam(":nomenfant",$nomEnf,PDO::PARAM_STR);
			$req->bindParam(":prenomenfant",$prenomEnf,PDO::PARAM_STR);
			$req->bindParam(":classe",$classe,PDO::PARAM_STR);
			$req->execute();
			$this->pdo->commit();
		}
		catch(PDOException $e){
			echo "Problème de communication avec la base de données!";
			$this->pdo->rollback();
		}
	}
}
?>