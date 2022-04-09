<?php

class controleur {
    function connexionUser() {
        $corpsRequete = file_get_contents('php://input');
		if($json = json_decode($corpsRequete,true))
		{
			if(isset($json["id"]) && isset($json["mdp"])){
                $verif = (new parents)->connect_verif($json["id"], $json["mdp"]);
                if($verif["Count(id)"]==1){
                    $hasValidCredentials = true;

                    if ($hasValidCredentials) {
                        $secretKey  = 'bGS6lzFqvvSQ8ALbOxatm7/Vk7mLQyzqaS34Q4oR1ew=';
                        $tokenId    = base64_encode(random_bytes(16));
                        $issuedAt   = new DateTimeImmutable();
                        $expire     = $issuedAt->modify('+60 minutes')->getTimestamp();      // Add 60 seconds
                        $serverName = "nomduhost";
                        $username   = $verif["id"];                                           // Retrieved from filtered POST data

                        // Create the token as an array
                        $data = [
                            'iat'  => $issuedAt->getTimestamp(),    // Issued at: time when the token was generated
                            'jti'  => $tokenId,                     // Json Token Id: an unique identifier for the token
                            'iss'  => $serverName,                  // Issuer
                            'nbf'  => $issuedAt->getTimestamp(),    // Not before
                            'exp'  => $expire,                      // Expire
                            'data' => [                             // Data related to the signer user
                                'userName' => $username,            // User name
                            ]
                        ];
        
                        // Encode the array to a JWT string.
                        echo Firebase\JWT\JWT::encode(
                            $data,      //Data to be encoded in the JWT
                            $secretKey, // The signing key
                            'HS512'     // Algorithm used to sign the token, see https://tools.ietf.org/html/draft-ietf-jose-json-web-algorithms-40#section-3
                        );
                    }
                }
            }
        }
    }

    function inscriptionUser() {
        $corpsRequete = file_get_contents('php://input');
        if($json = json_decode($corpsRequete,true))
        {
            if(isset($json["id"]) && isset($json["mdp"])){
                $verif = (new parents)->inscription($json["id"],$json["mdp"],$json["nomEnf"], $json["prenomEnf"], $json["classe"]);
            }
        }
    }

    function afficherLivre() {
        (new vue)->afficherObjetEnJSON((new Livre)->getAll());
    }

    function afficherNotes() {
        $corpsRequete = file_get_contents('php://input');
                $verif = (new note)->getNoteComm($_GET["idLivre"]);
                if(!empty($verif))
                    (new vue)->afficherObjetEnJSON($verif);
                else
                    (new vue)->afficherObjetEnJSON(false);
    }

    function ajouterNote() {
        $corpsRequete = file_get_contents('php://input');
        if($json = json_decode($corpsRequete,true))
        {
            if(isset($json["unParent"]) && isset($json["unLivre"])&& isset($json["uneNote"]) && isset($json["unCommentaire"])){
                $verif = (new note)->setNoteComm($json["unParent"],$json["unLivre"],$json["uneNote"],
                $json["unCommentaire"]);
            }
        }
    }
}
?>