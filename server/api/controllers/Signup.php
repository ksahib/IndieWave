<?php
include_once '../config/database.php';
include_once '../models/UserModel.php';
include_once 'BaseController.php';

class SignupController extends BaseController {
    private $userModel;

    public function __construct($db) {
        parent::__construct($db); 
        $this->userModel = new UserModel($this->db);
    }

    public function create() {
        $this->validateRequiredFields(['email', 'name', 'password']);

        $data = [
            'user_id' => uniqid(),
            'email' => $_POST['email'],
            'name' => $_POST['name'],
            'password' => password_hash($_POST['password'], PASSWORD_BCRYPT),
            'profile_pic' => null
        ];

        if ($this->userModel->create($data)) {
            $this->sendResponse(201, 'User created successfully.');
        } else {
            $this->sendResponse(500, 'Failed to create user.');
        }
    }
}
