<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/config/database.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/releasemodel.php';

include_once 'BaseController.php';

class Release extends BaseController {
    private $releaseModel;
    
    public function __construct($db) {
        parent::__construct($db);
        $this->releaseModel = new releasemodel($this->db);
    }

    public function create() {
        try{
            $data = json_decode(file_get_contents("php://input"), true); 
            $this->validateRequiredFields($data, ['artist_name', 'album_id']);
            
            if ($this->releaseModel->create($data)) {
                $this->sendResponse(201, 'New Album Released successfully.');
            } else {
                $this->sendResponse(500, 'Failed to release album');
            }
        } catch (Exception $e){
            $this->sendResponse(500, $e);
        }
    }


}


?>