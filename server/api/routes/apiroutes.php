<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/config/database.php';


$database = new Database();
$db = $database->getConnection();

function handlereq($method, $url)  {
    global $db;
    //extract controller and method from url
    $sections = explode('/', trim($url,'/'));
    //url format is /api/{controller}/{id}
    if(count($sections) < 3 || $sections[1] != 'api')  {
        http_response_code(404);
        echo json_encode(["message" => "Invalid URL"]);
        return;
    }

    $controllerName = ucfirst($sections[2]);
    echo json_encode(["controller" => $controllerName]);
    $controllerPath = $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/controllers/' . $controllerName . '.php';
    echo json_encode(["controllerPath" => $controllerPath]); // Send controller path as JSON response


    if (!file_exists($controllerPath)) {
        http_response_code(404);
        echo json_encode(['message' => 'Controller not found']);
        return;
    }

    include_once $controllerPath;
    $controller = new $controllerName($db);
    $id = isset($sections[3]) ? (int)$sections[3] : null;
    echo json_encode(["method" => $method]);
    switch ($method) {
        case 'GET':
            if ($id) {
                $response = $controller->getUser($id);
            } elseif (method_exists($controller, 'getAll')) { 
                // Check if getAll method exists before calling it
                $response = $controller->getAll();
            } else {
                $response = $controller->getAll();
            }
            break;

        case 'POST':
            $data = json_decode(file_get_contents("php://input"), true);
            if (json_last_error() !== JSON_ERROR_NONE) {
                http_response_code(400);
                echo json_encode(['message' => 'Invalid JSON']);
                return;
            }
            $response = $controller->create($data);
            break;

        case 'PUT':
            if (!$id) {
                http_response_code(400);
                echo json_encode(['message' => 'ID required for updating']);
                return;
            }
            $data = json_decode(file_get_contents("php://input"), true);
            if (json_last_error() !== JSON_ERROR_NONE) {
                http_response_code(400);
                echo json_encode(['message' => 'Invalid JSON']);
                return;
            }
            $response = $controller->update($id, $data);
            break;

        case 'DELETE':
            if (!$id) {
                http_response_code(400);
                echo json_encode(['message' => 'ID required for deleting']);
                return;
            }
            $response = $controller->delete($id);
            break;

        default:
            http_response_code(405);
            echo json_encode(['message' => 'Method not allowed']);
            return;
    }

    echo json_encode($response);
}
?>