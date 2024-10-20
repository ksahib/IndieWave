<?php
include_once '../config/database.php';

$database = new Database();
$db = $database->getConnection();

function handlereq($method, $url)  {
    //extract controller and method from url
    $sections = explode('/', trim($url,'/'));
    //url format is /api/{controller}/{id}
    if(count($sections) < 3 || $sections[0] != 'api')  {
        http_response_code(404);
        echo json_encode(["message" => "Invalid URL"]);
        return;
    }

    $controllerName = ucfirst($sections[1]).'Controller';
    $controllerPath = '../controllers/' . $controllerName . '.php';


    if (!file_exists($controllerPath)) {
        http_response_code(404);
        echo json_encode(['message' => 'Controller not found']);
        return;
    }

    include_once $controllerPath;
    $controller = new $controllerName($db);
    $id = isset($sections[2]) ? (int)$sections[2] : null;
    switch ($method) {
        case 'GET':
            if ($id) {
                $response = $controller->getUser($id);
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