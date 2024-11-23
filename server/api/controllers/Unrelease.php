<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/config/database.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/releasemodel.php';

include_once 'BaseController.php';

class Unrelease extends BaseController {
    private $releaseModel;
    
    public function __construct($db) {
        parent::__construct($db);
        $this->releaseModel = new releasemodel($this->db);
    }

    public function _get() {
        $headers = apache_request_headers();
        $album_id = $headers['album-id'];
        try{
            if(!$album_id) {
                $this->sendResponse(401, 'Invalid Request');
                return;
            }
            
            if($this->releaseModel->delete('album_id', $album_id))
            {
                $this->sendResponse(200, 'Album Unreleased Successfully');
            }
            else {
                $this->sendResponse(500, 'Error Unreleasing Album');
            }
            
        } catch (Exception $e){
            $this->sendResponse(500, $e);
        }
    }


}


?>