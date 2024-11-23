<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Credentials: true");
header("Access-Control-Allow-Headers: Content-Type");

require_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/vendor/autoload.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/config/database.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/releasemodel.php';

include_once 'BaseController.php';

class ReleaseStatus extends BaseController {
    private $releaseModel;

    public function __construct($db) {
        parent::__construct($db); 
        $this->releaseModel = new releasemodel($this->db);
    }

    public function _get() {
        $headers = apache_request_headers();
        $albumid =$headers['album-id'];
        

        try {
            if(!$albumid) {
                $this->sendResponse(401, 'Invalid Request');
                return;
            }
    
    
            $album = $this->releaseModel->get('album_id', $albumid);
            if(!$album) {
                $this->sendResponse(404, 'Album not found');
                return;
            } else {
                $this->sendResponse(200, 'Album was released');
            }
            
            
        }  catch(Exception $e)  {
            http_response_code(500);
        }
        
    }  
    

}
?>