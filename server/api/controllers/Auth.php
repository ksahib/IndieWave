<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Credentials: true");
header("Access-Control-Allow-Headers: Content-Type");

require_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/vendor/autoload.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/config/database.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/UserModel.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/sessionmodel.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/imagemodel.php';
include_once 'BaseController.php';
use \Firebase\JWT\JWT;
use Firebase\JWT\Key;

class Auth extends BaseController {
    private $userModel;
    private $sessionmodel;
    private $imagemodel;
    private $secret_key = "213g3v453tfgr34yvf238erg8evyu";

    public function __construct($db) {
        parent::__construct($db); 
        $this->userModel = new UserModel($this->db);
        $this->sessionmodel = new sessionmodel($this->db);
        $this->imagemodel = new imagemodel($this->db);
    }

    public function _get() {
        $headers = apache_request_headers();
        $token = $headers['x-auth-token'];
        

        try {
            if(!$token) {
                $this->sendResponse(401, 'No valid token found');
                return;
            }
    
            $decoded = JWT::decode($token, new Key($this->secret_key, 'HS256'));
    
            if(!$decoded) {
                $this->sendResponse(401, 'Damaged token');
                return;
            }
    
            $email = $decoded->data->email;
            $user = $this->userModel->get('email', $email);
            if(!$user) {
                $this->sendResponse(401, 'User not found');
                return;
            }

            $session = $this->sessionmodel->get('token_id', $token);
            if (!$session || empty($session["data"])){
                $this->sendResponse(401, 'Session not found');
                return;
            }
            else if (isset($session["data"]) && $session["data"]['expires_at'] < date('Y-m-d H:i:s')) {
                $this->sessionmodel->delete('token_id', $session["data"]['token_id']);
                $this->sendResponse(401, 'Your session has expired');
                return;
            }
            

            $imageid = $user["data"]["profile_pic"];
            $image = $this->imagemodel->get('image_id', $imageid);
            $this->sendResponse(200, 'Retrieved user data', [$user, $image]);
        }  catch(Exception $e)  {
            http_response_code(500);
            echo json_encode(["error" => $e->getMessage()]);
        }
        
    }  
    

}
?>