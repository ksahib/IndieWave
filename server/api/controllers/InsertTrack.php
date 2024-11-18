<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/config/database.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/trackModel.php';

include_once 'BaseController.php';

class InsertTrack extends BaseController {
    private $trackModel;
    
    public function __construct($db) {
        parent::__construct($db);
        $this->trackModel = new trackmodel($this->db);
    }

    public function create() {
        try{
            // Get input data
            $data = json_decode(file_get_contents("php://input"), true);
            // Validate required fields 
            $this->validateRequiredFields($data, ['track_name', 'tag', 'length', 'album_id']);
            
            // Set default values for fields that are not provided
            if(empty($data['track_url'])) {
                $data['track_url'] = "";
            }
            $data['track_id'] = uniqid();
            
            // Call the ArtistModel's create method to insert into the database
            if ($this->trackModel->create($data)) {
                $this->sendResponse(201, 'New Track added successfully.');
            } else {
                $this->sendResponse(500, 'Failed to add Track');
            }
        } catch (Exception $e){
            $this->sendResponse(500, 'Error / Album may not exist');
        }
    }


}


?>