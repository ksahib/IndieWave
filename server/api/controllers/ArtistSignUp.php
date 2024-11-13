<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/config/database.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/artistmodel.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/imagemodel.php';
include_once 'BaseController.php';

class ArtistSignUp extends BaseController {
    private $artistModel;
    private $imagemodel;

    public function __construct($db) {
        parent::__construct($db);
        $this->artistModel = new artistmodel($this->db);
        $this->imagemodel = new imagemodel($this->db);
    }

    public function create() {
        try{
            // Get input data
            $data = json_decode(file_get_contents("php://input"), true);
        
            // Validate required fields 
            $this->validateRequiredFields($data, ['email', 'artist_name', 'about']);
            
            // Set default values for fields that are not provided
            if($data['profile_pic'] === '') {
                $data['profile_pic'] = 'default';
            }
            $imageid = uniqid();
            $info = [
                'image_id' => $imageid,
                'image_url' => $data['profile_pic'],
                'image_type' => 'profile_pic',
            ];
            if($this->imagemodel->create($info))
            {
                $data['profile_pic'] = $imageid;
            }
            else
            {
                $this->sendResponse(500, "Failed to upload image");
                echo json_encode(['images'=>$info]);
            }
            $data['follower_count'] = 0;

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
