-- --------------------------------------------------------
-- Hôte:                         baruff.fr
-- Version du serveur:           10.5.12-MariaDB-0+deb11u1 - Debian 11
-- SE du serveur:                debian-linux-gnu
-- HeidiSQL Version:             11.2.0.6213
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Listage de la structure de la base pour projet_livre
CREATE DATABASE IF NOT EXISTS `projet_livre` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `projet_livre`;

-- Listage de la structure de la table projet_livre. Avoir
CREATE TABLE IF NOT EXISTS `Avoir` (
  `idParent` int(11) DEFAULT NULL,
  `idEnfant` int(11) DEFAULT NULL,
  KEY `FK__Parent` (`idParent`),
  KEY `FK__Enfant` (`idEnfant`),
  CONSTRAINT `FK__Enfant` FOREIGN KEY (`idEnfant`) REFERENCES `Enfant` (`id`),
  CONSTRAINT `FK__Parent` FOREIGN KEY (`idParent`) REFERENCES `Parent` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Listage des données de la table projet_livre.Avoir : ~9 rows (environ)
/*!40000 ALTER TABLE `Avoir` DISABLE KEYS */;
INSERT INTO `Avoir` (`idParent`, `idEnfant`) VALUES
	(1, 1),
	(2, 2),
	(3, 3),
	(4, 4),
	(5, 5),
	(6, 6),
	(7, 7),
	(8, 8),
	(9, 9);
/*!40000 ALTER TABLE `Avoir` ENABLE KEYS */;

-- Listage de la structure de la table projet_livre. Enfant
CREATE TABLE IF NOT EXISTS `Enfant` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(30) NOT NULL DEFAULT '0',
  `prenom` varchar(30) DEFAULT NULL,
  `classe` varchar(20) NOT NULL DEFAULT '0' COMMENT 'SHA256(*//mdp//*)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;

-- Listage des données de la table projet_livre.Enfant : ~9 rows (environ)
/*!40000 ALTER TABLE `Enfant` DISABLE KEYS */;
INSERT INTO `Enfant` (`id`, `nom`, `prenom`, `classe`) VALUES
	(1, 'testEnfant', 'testEnfant', 'testClasse'),
	(2, 'arno', 'arno', 'ce1'),
	(3, 'nomenfant', 'prenomenfant', 'classe'),
	(4, 'nomenfant', 'prenomenfant', 'classe'),
	(5, 'nomenfant', 'prenomenfant', 'classe'),
	(6, 'nomenfant', 'prenomenfant', 'classe'),
	(7, 'nomenfant', 'prenomenfant', 'classe'),
	(8, 'nomenfant', 'prenomenfant', 'classe'),
	(9, 'nomenfant', 'prenomenfant', 'classe');
/*!40000 ALTER TABLE `Enfant` ENABLE KEYS */;

-- Listage de la structure de la procédure projet_livre. InscrireParent
DELIMITER //
CREATE PROCEDURE `InscrireParent`(IN iden VARCHAR(30),IN mdp VARCHAR (64),IN nomEnf VARCHAR(30), IN prenomEnf VARCHAR(30), IN classeEnf VARCHAR(20))
BEGIN
INSERT INTO Parent VALUES(null,iden,mdp);
INSERT INTO Enfant VALUES(NULL,nomEnf,prenomEnf,classeEnf);
INSERT INTO Avoir VALUES((SELECT MAX(Parent.id) FROM Parent),(SELECT MAX(Enfant.id) FROM Enfant));
END//
DELIMITER ;

-- Listage de la structure de la table projet_livre. Livre
CREATE TABLE IF NOT EXISTS `Livre` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Titre` varchar(100) NOT NULL DEFAULT '0',
  `Auteur` varchar(100) DEFAULT NULL,
  `ISBN` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4;

-- Listage des données de la table projet_livre.Livre : ~17 rows (environ)
/*!40000 ALTER TABLE `Livre` DISABLE KEYS */;
INSERT INTO `Livre` (`id`, `Titre`, `Auteur`, `ISBN`) VALUES
	(1, 'Mon fils ma bataille', 'le Z', '2'),
	(2, 'Combat', 'laid', '3'),
	(3, 'OUI-OUI', 'Enid Blyton', '1'),
	(4, 'Mickey mousse', 'pierre', '4'),
	(5, 'Les barbes a tonton', 'mon Tonton', '5'),
	(6, 'Martine découvre le canibalisme', 'Martoche', '6'),
	(7, 'Recette de choucroute', 'alca=sace', '12'),
	(8, 'Le suicide français', 'Eric', '7'),
	(9, 'Le temps des tempêtes', 'Nico', '8'),
	(10, 'le guide du zizi sexuel', 'zep', '9'),
	(11, 'Anne-Sophie', 'Baruff', '10'),
	(12, 'Flavie', 'Baruff', '11'),
	(13, 'Rose', 'Raph', '14'),
	(14, 'Il est rentré dans la Marine!', 'Baruff', '13'),
	(15, 'Super niquel!', 'Michel Dumat', '15'),
	(16, 'Super nani', 'Tati', '16'),
	(17, 'origina', 'Baruff', '17');
/*!40000 ALTER TABLE `Livre` ENABLE KEYS */;

-- Listage de la structure de la table projet_livre. Noter
CREATE TABLE IF NOT EXISTS `Noter` (
  `idParent` int(11) NOT NULL,
  `idLivre` int(11) NOT NULL,
  `dateNote` date NOT NULL,
  `note` tinytext DEFAULT NULL,
  `commentaire` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`idParent`,`idLivre`,`dateNote`),
  KEY `FK_Noter_Livre` (`idLivre`),
  KEY `FK_Noter_Enfant` (`idParent`) USING BTREE,
  CONSTRAINT `FK_Noter_Livre` FOREIGN KEY (`idLivre`) REFERENCES `Livre` (`id`),
  CONSTRAINT `FK_Noter_Parent` FOREIGN KEY (`idParent`) REFERENCES `Parent` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Listage des données de la table projet_livre.Noter : ~4 rows (environ)
/*!40000 ALTER TABLE `Noter` DISABLE KEYS */;
INSERT INTO `Noter` (`idParent`, `idLivre`, `dateNote`, `note`, `commentaire`) VALUES
	(1, 1, '2022-04-08', '10', 'aa'),
	(1, 9, '2022-04-08', '7', 'aa'),
	(1, 12, '2022-04-08', '9', 'Voici un magnifique commentaire!'),
	(2, 10, '2022-04-08', '10', 'aa');
/*!40000 ALTER TABLE `Noter` ENABLE KEYS */;

-- Listage de la structure de la table projet_livre. Parent
CREATE TABLE IF NOT EXISTS `Parent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifiant` varchar(30) DEFAULT NULL,
  `motDePasse` varchar(64) DEFAULT NULL COMMENT 'SHA256(*//mdp//*)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COMMENT='mdp test= identifiant';

-- Listage des données de la table projet_livre.Parent : ~9 rows (environ)
/*!40000 ALTER TABLE `Parent` DISABLE KEYS */;
INSERT INTO `Parent` (`id`, `identifiant`, `motDePasse`) VALUES
	(1, 'test', 'e9810be42b641ac22263b6acf79e0afed1f3b466cd966a5872ebb184c8e42231'),
	(2, 'alizee', '564af63730aa2443f01789d801391af826f21e177f3d98e68acf4ae1297f91d6'),
	(3, 'testinscription', '5b10407decef880044a6b9160c4779da9e3aab9768a9bf77fe5b958184107e46'),
	(4, 'testinscription', '5b10407decef880044a6b9160c4779da9e3aab9768a9bf77fe5b958184107e46'),
	(5, 'testinscription', '5b10407decef880044a6b9160c4779da9e3aab9768a9bf77fe5b958184107e46'),
	(6, 'testinscription', '5b10407decef880044a6b9160c4779da9e3aab9768a9bf77fe5b958184107e46'),
	(7, 'testinscription', '5b10407decef880044a6b9160c4779da9e3aab9768a9bf77fe5b958184107e46'),
	(8, 'testinscription', '5b10407decef880044a6b9160c4779da9e3aab9768a9bf77fe5b958184107e46'),
	(9, 'testinscription', '5b10407decef880044a6b9160c4779da9e3aab9768a9bf77fe5b958184107e46');
/*!40000 ALTER TABLE `Parent` ENABLE KEYS */;

-- Listage de la structure de la procédure projet_livre. SelectComNote
DELIMITER //
CREATE PROCEDURE `SelectComNote`(
	IN `unLivre` INT
)
BEGIN
SELECT Noter.commentaire,Noter.note FROM Noter WHERE idLivre=unLivre;
END//
DELIMITER ;

-- Listage de la structure de déclencheur projet_livre. verifNote
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER verifNote
BEFORE INSERT
ON Noter
FOR EACH ROW
BEGIN
	IF NEW.note<0 THEN
		SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT="La note n\'est pas comprise ente 0 et 10!";
	END IF;
	IF NEW.note>10 THEN
		SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT="La note n\'est pas comprise ente 0 et 10!";
	END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
