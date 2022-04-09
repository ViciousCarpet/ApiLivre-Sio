<?php
session_start();
use Firebase\JWT\JWT;
require_once('../vendor/autoload.php');
error_reporting(E_ALL);
ini_set("display_errors", 1);

// Test de connexion à la base
$config = parse_ini_file("config.ini");
try {
	$pdo = new \PDO("mysql:host=".$config["host"].";dbname=".$config["database"].";charset=utf8", $config["user"], $config["password"]);
} catch(Exception $e) {
	echo "<h1>Erreur de connexion à la base de données :</h1>";
	echo $e->getMessage();
	exit;
}

require("view/vue.php");
require("controler/controleur.php");
require("model/note.php");
require("model/livre.php");
require("model/parent.php");


switch($_GET["action"]) {
	case "connexion":
		switch($_SERVER["REQUEST_METHOD"]) {
			case "POST":
				(new controleur)->connexionUser();
				break;
			case "PUT":
				(new controleur)->inscriptionUser();
				break;
		}
		break;

	case "livre":
		switch($_SERVER["REQUEST_METHOD"]) {
			case "GET":
				(new controleur)->afficherLivre();
				break;
		}
		break;

	case "note":
		switch($_SERVER["REQUEST_METHOD"]) {
			case "GET":
				(new controleur)->afficherNotes();
				break;
			case "POST":
				(new controleur)->ajouterNote();
				break;
		}
		break;
}
?>