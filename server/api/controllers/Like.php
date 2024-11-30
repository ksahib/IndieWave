<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/config/database.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/likemodel.php';

include_once 'BaseController.php';

class Like extends BaseController {
    private $likeModel;

    public function __construct($db) {
        parent::__construct($db);
        $this->likeModel = new likemodel($this->db);
    }

    public function create() {
        try{

            $data = json_decode(file_get_contents("php://input"), true);
        
            $this->validateRequiredFields($data, ['email', 'track_id']);
        
            // Call the ArtistModel's create method to insert into the database
            if ($this->likeModel->create($data)) {
                $this->sendResponse(201, 'User liked track.');
            } else {
                $this->sendResponse(500, 'Error inserting like');
            }
        } catch (Exception $e){
            $this->sendResponse(500, 'Error');
        }
    }


}


?>