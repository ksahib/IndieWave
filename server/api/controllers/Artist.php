<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Credentials: true");
header("Access-Control-Allow-Headers: Content-Type");

require_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/vendor/autoload.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/config/database.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/artistmodel.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/imagemodel.php';

include_once 'BaseController.php';
use \Firebase\JWT\JWT;
use Firebase\JWT\Key;

class Artist extends BaseController {
    private $artistModel;
    private $imagemodel;
    private $secret_key = "213g3v453tfgr34yvf238erg8evyu";

    public function __construct($db) {
        parent::__construct($db); 
        $this->artistModel = new artistmodel($this->db);
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
            $artist = $this->artistModel->get('email', $email);
            if(!$artist) {
                $this->sendResponse(401, 'User not found');
                return;
            }
            

            $imageid = $artist["data"]["profile_pic"];
            $image = $this->imagemodel->get('image_id', $imageid);
            $this->sendResponse(200, 'Retrieved Artist data', ['email' => $email,'artist_name' => $artist["data"]["artist_name"], 'about' => $artist["data"]["about"], 'follower_count' => $artist["data"]["follower_count"], 'image_url' => $image["data"]["image_url"]]);
        }  catch(Exception $e)  {
            http_response_code(500);
            echo json_encode(["error" => $e->getMessage()]);
        }
        
    }  
    

}
?>