<?php
// use Parents;
use PHPUnit\Framework\TestCase;
include "/var/www/html/MVC/model/parent.php";

class TestParent extends TestCase
{
    /**
     * @test
     * 1) Vérifier l'inscription d'un parent.
     */
    public function testInscription(){
        
        $par = new Parents();    
        $inscri=$par->inscription("testinscription","testinscription","nomenfant","prenomenfant","classe");
        $this->assertSame($inscri,null);//Vérifie qu'un message d'erreur n'est pas retourné.

        $token=$par->connect_verif("testinscription","testinscription");
        $this->assertSame(isset($token),true);//Vérifie l'inscription en vérifiant qu'un token est reçu en se connectant
        


    }
}