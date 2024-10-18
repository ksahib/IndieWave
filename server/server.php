<?php

$host = "localhost";
$username = "root";
$password = "";
$db = "indiewave";

try {
    $pdo = new PDO("mysql:host=$host;dbname=$db", $username, $password);
    echo "Connected";
} catch(PDOException $e) {
    die("Database connection failed: ".$e->getMessage());
}

function signup($mail, $name, $pass)  {
    global $pdo;
    $stmt = $pdo->prepare("SELECT * FROM users WHERE mail = ?");
    $stmt->execute([$mail]);
    if ($stmt->rowCount() > 0) {
        return ['status' => 'error', 'message' => 'This email is already registered to an account'];
    }
    
    $hash_pass = password_hash($pass, PASSWORD_BCRYPT);

    $profile_pic = null;

    $stmt = $pdo->prepare("INSERT INTO users (user_id, mail, name, pass, profile_pic) VALUES (UUID(), ?, ?, ?, ?)");
    if ($stmt->execute([$mail, $name, $hash_pass, $profile_pic])) {
        return ['status' => 'success', 'message' => 'User registered successfully'];
    } else {
        return ['status' => 'error', 'message' => 'Error registering user'];
    }

    $request_uri = $_SERVER['REQUEST_URI'];

    switch ($request_uri) {
        case '/signup':
            // Handles POST request for signup
            if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                // Retrieves input data from the request
                $mail = $_POST['mail'];
                $name = $_POST['name'] ?? '';
                $password = $_POST['password'] ?? '';
                $profile_pic = null;

                // Call the signup function
                $response = signup($mail, $name, $password);

                // Return the response as JSON
                header('Content-Type: application/json');
                echo json_encode($response);
            } else {
                // Handle other request methods (e.g., GET)
                header("HTTP/1.1 405 Method Not Allowed");
                echo json_encode(['status' => 'error', 'message' => 'Method not allowed']);
            }
            break;

        default:
            // Handle 404 Not Found
            header("HTTP/1.1 404 Not Found");
            echo json_encode(['status' => 'error', 'message' => 'Not Found']);
            break;
}
}




function handlelogin()  {
    
}
?>