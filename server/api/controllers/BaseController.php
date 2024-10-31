<?php

class BaseController {
    protected $db;

    public function __construct($db) {
        $this->db = $db;
    }

    //send JSON response
    protected function sendResponse($status, $message, $data = null) {
        header('Content-Type: application/json');
        http_response_code($status);
        echo json_encode(['status' => $status, 'message' => $message, 'data' => $data]);
        exit();
    }

    //validate required fields in POST requests
    protected function validateRequiredFields($data, $requiredFields) {
        foreach ($requiredFields as $field) {
            if (!isset($data[$field])) {
                $this->sendResponse(400, "Missing required field: $field");
            }
        }
    }

    //GET requests
    protected function Get($callback) {
        if ($_SERVER['REQUEST_METHOD'] === 'GET') {
            call_user_func($callback);//call_user_func is used to call a function defined in the future. The first parameter takes a string which contains the name of a function, 
            //or the name of an obj and then the function or the  name of a class and then the function to be called. 
            //The subsequent parameters are the parameters to be passed in the function called. 
        } else {
            $this->sendResponse(405, 'Method Not Allowed. Use GET.');
        }
    }

    // POST requests
    protected function Post($callback) {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            call_user_func($callback);
        } else {
            $this->sendResponse(405, 'Method Not Allowed. Use POST.');
        }
    }

    // PUT requests
    protected function Put($callback) {
        if ($_SERVER['REQUEST_METHOD'] === 'PUT') {
            parse_str(file_get_contents("php://input"), $_PUT);
            call_user_func($callback, $_PUT);
        } else {
            $this->sendResponse(405, 'Method Not Allowed. Use PUT.');
        }
    }

    // DELETE requests
    protected function Delete($callback) {
        if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
            call_user_func($callback);
        } else {
            $this->sendResponse(405, 'Method Not Allowed. Use DELETE.');
        }
    }
}
