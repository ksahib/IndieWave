<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Credentials: true");
header("Access-Control-Allow-Headers: Content-Type");

require_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/vendor/autoload.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/config/database.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/likemodel.php';

include_once 'BaseController.php';

class LikeStatus extends BaseController {
    private $likeModel;

    public function __construct($db) {
        parent::__construct($db); 
        $this->likeModel = new likemodel($this->db);
    }

    public function _get() {
        $headers = apache_request_headers();
        $user =$headers['email'];
        $track =$headers['track-id'];
        

        try {
            if(!$track) {
                $this->sendResponse(401, 'Invalid Request');
                return;
            }
    
    
            $query = "SELECT * FROM likes WHERE email = :email AND track_id = :track";
            $stmt = $this->db->prepare($query);
            $stmt->bindParam(':email', $user);
            $stmt->bindParam(':track', $track);
            $stmt->execute();
            $result = $stmt->fetch(PDO::FETCH_ASSOC);
            if(!$result) {
                $this->sendResponse(404, 'Record not found');
                return;
            } else {
                $this->sendResponse(200, 'Record found');
            }
            
            
        }  catch(Exception $e)  {
            http_response_code(500);
        }
        
    }  
    

}
?>