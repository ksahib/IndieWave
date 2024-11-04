<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/config/database.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/UserModel.php';
include_once 'BaseController.php';

class Signup extends BaseController {
    private $userModel;

    public function __construct($db) {
        parent::__construct($db); 
        $this->userModel = new UserModel($this->db);
    }

    public function create() {
        $data = json_decode(file_get_contents("php://input"), true);
        $this->validateRequiredFields($data, ['email', 'name', 'password']);
        file_put_contents('log.txt', print_r($_POST, true), FILE_APPEND);

        //echo json_encode(["field contents" => $data]);
        $data['password'] = password_hash($data['password'], PASSWORD_BCRYPT);
        $data['profile_pic'] = null;

        if ($this->userModel->create($data)) {
            $this->sendResponse(201, 'User created successfully.');
        } else {
            $this->sendResponse(500, 'Failed to create user.');
        }
    }
}
