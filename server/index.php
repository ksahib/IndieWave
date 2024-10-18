<?php
    include_once './routes/apiroutes.php';
    header("Content-Type: application/json");
    $method = $_SERVER['REQUEST_METHOD'];
    $url = $_SERVER['REQUEST_URI'];

    handlereq($method, $url);
?>
