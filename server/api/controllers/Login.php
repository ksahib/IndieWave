<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Credentials: true");
header("Access-Control-Allow-Headers: Content-Type");

require_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/vendor/autoload.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/config/database.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/UserModel.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/sessionmodel.php';
include_once 'BaseController.php';
use \Firebase\JWT\JWT;
use Firebase\JWT\Key;

class Login extends BaseController {
    private $userModel;
    private $sessionmodel;
    private $secret_key = "213g3v453tfgr34yvf238erg8evyu";

    public function __construct($db) {
        parent::__construct($db); 
        $this->userModel = new UserModel($this->db);
        $this->sessionmodel = new sessionmodel($this->db);
    }
    
    public function create()  {
        $data = json_decode(file_get_contents("php://input"), true);
        $this->validateRequiredFields($data, ['email', 'password', 'keepLoggedIn']);
        //echo json_encode(["field contents" => $data]);
        $email = $data['email'];
        $password = $data['password'];
        
        $user = $this->userModel->get('email', $email);
        //echo json_encode(["User table:" => $user]);
        if(!$user)  {
            $this->sendResponse(401, 'Invalid email. Account does not exist');
            return;
        }

        elseif(!password_verify($password, $user['data']['password']))  {
            $this->sendResponse(401, 'Invalid password');
            return;
        }
        $keeplogged = $data['keepLoggedIn'];
        $short_lived = time() + (12 * 60 * 60);
        $long_lived = time() + (30 * 24 * 60 * 60);
        $expiry = $keeplogged ? $long_lived : $short_lived;
        $expires_at = date('Y-m-d H:i:s', $expiry);

        $payload = [
            "iat" => time(),
            "exp" => $expiry,
            "data" => [
                "email" => $email,
                "unique" => uniqid(),
            ]
        ];
        
        $token = JWT::encode($payload, $this->secret_key, 'HS256');

        $info = [
            'token_id' => $token,
            'email' => $email,
            'expires_at' => $expires_at,
        ];


        if($this->sessionmodel->create($info))  {
            $this->sendResponse(200, 'Session created', ['token' => $token, 'user' => $user]);
        }  else {
            $this->sendResponse(500, 'Failed to create session');
        }

    }

}
?>
