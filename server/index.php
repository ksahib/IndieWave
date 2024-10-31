<?php
    header("Access-Control-Allow-Origin: *");
    header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
    header("Access-Control-Allow-Headers: Content-Type, Authorization");
    
    include_once './api/routes/apiroutes.php';
    header("Content-Type: application/json");
    $method = $_SERVER['REQUEST_METHOD'];
    $url = $_SERVER['REQUEST_URI'];

    handlereq($method, $url);
?>
