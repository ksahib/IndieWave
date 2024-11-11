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

    // public function autoLogin() {
    //     $headers = apache_request_headers();
    //     $authHeader = $headers['x-auth-token'] ?? '';
    //     //echo json_encode(["session data" => $session]);

    //     if($authHeader) {
    //         $token = $authHeader;
    //         $session = $this->sessionmodel->get('token_id', $token);
    //         try {
    //             $decoded = JWT::decode($token, new Key($this->secret_key, 'HS256'));
                
    //             // Check if token is near expiration (e.g., within 2 days)
    //             $expiryDate = new DateTime($session['data']['expires_at']);
    //             $currentDate = new DateTime();
    //             $interval = $currentDate->diff($expiryDate);

    //             if (!$session || new DateTime() > new DateTime($session['data']['expires_at'])) {
    //                 $this->sendResponse(401, 'Invalid or expired session token. Please log in.');
    //                 return;
    //             }

                

    //             if ($interval->days <= 2) { // If close to expiring, extend the expiration
    //                 $newExpiresAt = time() + (7 * 24 * 60 * 60);
    //                 $decoded->exp = $newExpiresAt;
    //                 $expires_at = date('Y-m-d H:i:s', $newExpiresAt);
    //                 // Update the jwt expiration on the client
    //                 $decodedArray = json_decode(json_encode($decoded), true);
    //                 $new_token = JWT::encode($decodedArray, $this->secret_key, 'HS256');
    //                 $update_list = [
    //                     'token_id' => $new_token,
    //                     'expires_at' => $expires_at,
    //                     'last_used' => $currentDate
    //                 ];
    //                 // Update the session expiration in the database
    //                 $this->sessionmodel->update($session['data']['token_id'], $update_list, 'token_id');
                    
    //                 $this->sendResponse(200, 'Token refreshed', ['token' => $new_token]);
    //                 return;    
    //             }

    //             $this->sendResponse(200, 'Automatically logged in.');
    //         } catch (Exception $e) {
    //             http_response_code(500);
    //             echo json_encode(["error" => $e->getMessage()]);
    //         }
    //     }
    
        
    
        
        
        
    
    //     // User is authenticated, proceed with auto-login
    //     $this->sendResponse(200, 'User automatically logged in');
    // }
    

   

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