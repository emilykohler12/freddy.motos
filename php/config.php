<?php

$servername = "localhost";
$username = "root";
$password = "2602";
$dbname = "freddymotos";

try {
    $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    echo "Conexión exitosa"; 
}
catch(PDOException $e) {
    echo "Error de conexión: " . $e->getMessage();
}
?>
