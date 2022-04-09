<?php
use Firebase\JWT\JWT;

require_once('./vendor/autoload.php');

ini_set('display_errors', 1); ini_set('display_startup_errors', 1); error_reporting(E_ALL);

$corpsRequete = file_get_contents('php://input');

if($json = json_decode($corpsRequete, true)) {
    if(isset($json["id"]) && isset($json["mdp"])) {
        if($json["id"]=="aa" && hash("sha256","*//".$json["mdp"]."//*")==hash("sha256","*//aa//*")) {
            $hasValidCredentials = true;

            if ($hasValidCredentials) {
                $secretKey  = 'bGS6lzFqvvSQ8ALbOxatm7/Vk7mLQyzqaS34Q4oR1ew=';
                $tokenId    = base64_encode(random_bytes(16));
                $issuedAt   = new DateTimeImmutable();
                $expire     = $issuedAt->modify('+60 minutes')->getTimestamp();      // Add 60 seconds
                $serverName = "your.domain.name";
                $username   = "username";                                           // Retrieved from filtered POST data

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
                echo JWT::encode(
                    $data,      //Data to be encoded in the JWT
                    $secretKey, // The signing key
                    'HS512'     // Algorithm used to sign the token, see https://tools.ietf.org/html/draft-ietf-jose-json-web-algorithms-40#section-3
                );
            }

        }
        else {
        http_response_code(400);
    
        $json = '{ "code":400, "message": "Données manquantes." }';
        header("Content-type: application/json; charset=utf-8");
		header("Access-Control-Allow-Origin: *");
        echo $json;
        }
        
    }
    
}
else {
    http_response_code(400);
    
    $json = '{ "code":400, "message": "Le corps de la requête est invalide." }';
    header("Content-type: application/json; charset=utf-8");
    header("Access-Control-Allow-Origin: *");
    echo $json;
}


?>