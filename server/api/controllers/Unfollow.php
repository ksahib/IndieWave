<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/config/database.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/followmodel.php';

include_once 'BaseController.php';

class Unfollow extends BaseController {
    private $followModel;

    public function __construct($db) {
        parent::__construct($db);
        $this->followModel = new followmodel($this->db);
    }

    public function _get() {
        $headers = apache_request_headers();
        $email = $headers['email'];
        $artist = $headers['artist_name'];
        
        

        try {
            if(!$email || !$artist) {
                $this->sendResponse(401, 'Email/Artist not valid');
                return;
            }
    
            $this->followModel->delete($email, $artist);
            
            $this->sendResponse(200, 'Unfollowed succesfully');
        }  catch(Exception $e)  {
            http_response_code(500);
            echo json_encode(["error" => $e->getMessage()]);
        }
    }


}


?>