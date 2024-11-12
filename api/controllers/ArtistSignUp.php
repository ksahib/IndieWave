<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/config/database.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/artistmodel.php';
include_once 'BaseController.php';

class ArtistSignUp extends BaseController {
    private $artistModel;

    public function __construct($db) {
        parent::__construct($db);
        $this->artistModel = new artistmodel($this->db);
    }

    public function create() {
        try{
            // Get input data
            $data = json_decode(file_get_contents("php://input"), true);
        
            // Validate required fields 
            $this->validateRequiredFields($data, ['email', 'artist_name', 'about', 'password']);
            
            // Set default values for fields that are not provided
            $data['profile_pic'] = 'default';
            $data['follower_count'] = 0;
            $data['password'] = password_hash($data['password'], PASSWORD_BCRYPT);
            //$this->sendResponse(201, 'Artist profile creating');

            // Call the ArtistModel's create method to insert into the database
            if ($this->artistModel->create($data)) {
                $this->sendResponse(201, 'Artist profile created successfully.');
            } else {
                $this->sendResponse(500, 'Failed to create artist profile.');
            }
        } catch (PDOException $e){
            $this->sendResponse(500, 'Artist already exists.');
        }
    }


}


?>
