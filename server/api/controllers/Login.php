<?php
include_once '../config/database.php';
include_once '../models/UserModel.php';
include_once 'BaseController.php';

class LoginController extends BaseController {
    private $userModel;

    public function __construct($db) {
        parent::__construct($db); 
        $this->userModel = new UserModel($this->db);
    }

    public function login()  {
        $this->validateRequiredFields(['email', 'password']);

        $email = $_POST['email'];
        $password = $_POST['password'];

        $user = $this->userModel->get($email);

        if(!$user)  {
            $this->sendResponse(401, 'Invalid email. Account does not exist');
            return;
        }

        elseif(!password_verify($password, $user['password']))  {
            $this->sendResponse(401, 'Invalid password');
            return;
        }

        $this->sendResponse(200, 'Login successful');


    }
}
?>