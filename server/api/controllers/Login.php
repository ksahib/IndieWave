<?php
header("Access-Control-Allow-Origin: *");  // Replace with the actual origin
header("Access-Control-Allow-Credentials: true");
header("Access-Control-Allow-Headers: Content-Type");

include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/config/database.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/UserModel.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/sessionmodel.php';
include_once 'BaseController.php';

class Login extends BaseController {
    private $userModel;
    private $sessionmodel;

    public function __construct($db) {
        parent::__construct($db); 
        $this->userModel = new UserModel($this->db);
        $this->sessionmodel = new sessionmodel($this->db);
    }

    public function autoLogin() {
        $token = $_COOKIE['auth_token'];
        $session = $this->sessionmodel->get('token_id', $token);
        echo json_encode(["session data" => $session]);
    
        if (!$session || new DateTime() > new DateTime($session['data']['expires_at'])) {
            $this->sendResponse(401, 'Invalid or expired session token. Please log in.');
            return;
        }
    
        // Check if token is near expiration (e.g., within 2 days)
        $expiryDate = new DateTime($session['data']['expires_at']);
        $currentDate = new DateTime();
        $interval = $currentDate->diff($expiryDate);
        
        if ($interval->days <= 2) { // If close to expiring, extend the expiration
            $newExpiresAt = time() + (7 * 24 * 60 * 60);
            $expires_at = date('Y-m-d H:i:s', $newExpiresAt);
            $update_list = [
                'expires_at' => $expires_at,
                'last_used' => $currentDate
            ];
            // Update the session expiration in the database
            $this->sessionmodel->update($session['data']['token_id'], $update_list, 'token_id');
    
            // Update the cookie expiration on the client
            setcookie("auth_token", $token, [
                'expires' => $newExpiresAt,
                'path' => '/',
                'secure' => false,
                'httponly' => true,
                'samesite' => 'Lax'
            ]);
        }
    
        // User is authenticated, proceed with auto-login
        $this->sendResponse(200, 'User automatically logged in');
    }
    

   

    public function create()  {
        if (isset($_COOKIE['auth_token'])) {
            $this->autoLogin();
            return;
        }
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
        $keeplogged = $data['keepLoggedIn'];
        $short_lived = time() + (12 * 60 * 60);
        $long_lived = time() + (30 * 24 * 60 * 60);
        $expiry = $keeplogged ? $long_lived : $short_lived;
        $expires_at = date('Y-m-d H:i:s', $expiry);

        setcookie("auth_token", $token, [
            'expires' => $expiry,
            'path' => '/',
            'secure' => false,
            'httponly' => true,
            'samesite' => 'Lax'
        ]);

        $info = [
            'token_id' => $token,
            'email' => $email,
            'expires_at' => $expires_at,
        ];


        if($this->sessionmodel->create($info))  {
            $this->sendResponse(200, 'Session created');
        }  else {
            $this->sendResponse(500, 'Failed to create session');
        }

    }

}
?>