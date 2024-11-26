<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/config/database.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/streamsmodel.php';

include_once 'BaseController.php';

class streamAdd extends BaseController {
    private $streamModel;

    public function __construct($db) {
        parent::__construct($db);
        $this->streamModel = new streamsModel($this->db);
    }

    public function create() {
        try{

            $data = json_decode(file_get_contents("php://input"), true);
        
            $this->validateRequiredFields($data, ['email', 'track_id']);
        
            // Call the ArtistModel's create method to insert into the database
            if ($this->streamModel->create($data)) {
                $this->sendResponse(201, 'Stream added.');
            } else {
                $this->sendResponse(500, 'Error inserting like');
            }
        } catch (Exception $e){
            $this->sendResponse(500, 'Error');
        }
    }


}


?>