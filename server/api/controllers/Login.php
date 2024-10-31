<?php
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/config/database.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/UserModel.php';
include_once 'BaseController.php';

class Login extends BaseController {
    private $userModel;

    public function __construct($db) {
        parent::__construct($db); 
        $this->userModel = new UserModel($this->db);
    }

    public function create()  {
        $data = json_decode(file_get_contents("php://input"), true);
        $this->validateRequiredFields($data, ['email', 'password', 'keepLoggedIn']);
        echo json_encode(["field contents" => $data]);
        $email = $data['email'];
        $password = $data['password'];
        $token = bin2hex(random_bytes(16));
        $user = $this->userModel->get('email', $email);
        echo json_encode(["User table:" => $user]);
        if(!$user)  {
            $this->sendResponse(401, 'Invalid email. Account does not exist');
            return;
        }

        elseif(!password_verify($password, $user['data']['password']))  {
            $this->sendResponse(401, 'Invalid password');
            return;
        }

        $this->sendResponse(200, 'Login successful');
        


    }
}
?>