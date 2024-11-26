<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/config/database.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/likemodel.php';

include_once 'BaseController.php';

class Unlike extends BaseController {
    private $likeModel;

    public function __construct($db) {
        parent::__construct($db);
        $this->likeModel = new likemodel($this->db);
    }

    public function _get() {
        $headers = apache_request_headers();
        $email = $headers['email'];
        $track = $headers['track-id'];
        
        

        try {
            if(!$email || !$track) {
                $this->sendResponse(401, 'Email/Track not valid');
                return;
            }
    
            $this->likeModel->delete($email, $track);
            
            $this->sendResponse(200, 'unliked succesfully');
        }  catch(Exception $e)  {
            http_response_code(500);
            echo json_encode(["error" => $e->getMessage()]);
        }
    }


}


?>