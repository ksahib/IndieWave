<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Credentials: true");
header("Access-Control-Allow-Headers: Content-Type");

require_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/vendor/autoload.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/config/database.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/followModel.php';

include_once 'BaseController.php';

class FollowStatus extends BaseController {
    private $followModel;

    public function __construct($db) {
        parent::__construct($db); 
        $this->followModel = new followModel($this->db);
    }

    public function _get() {
        $headers = apache_request_headers();
        $user =$headers['email'];
        $artist =$headers['artist-name'];
        

        try {
            if(!$artist) {
                $this->sendResponse(401, 'Invalid Request');
                return;
            }
    
    
            $query = "SELECT * FROM follows WHERE email = :email AND artist_name = :artist";
            $stmt = $this->db->prepare($query);
            $stmt->bindParam(':email', $user);
            $stmt->bindParam(':artist', $artist);
            $stmt->execute();
            $result = $stmt->fetch(PDO::FETCH_ASSOC);
            if(!$result) {
                $this->sendResponse(404, 'can not follow');
                return;
            } else {
                $this->sendResponse(200, 'Followed');
            }
            
            
        }  catch(Exception $e)  {
            http_response_code(500);
        }
        
    }  
    

}
?>