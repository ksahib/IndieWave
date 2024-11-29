<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/config/database.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/usermodel.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/imagemodel.php';
include_once 'BaseController.php';


class ProfilePicture extends BaseController {
    private $userModel;
    private $imagemodel;

    public function __construct($db) {
        parent::__construct($db);
        $this->userModel = new Usermodel($this->db);
        $this->imagemodel = new imagemodel($this->db);
    }

    public function create() {
        try{
            // Get input data
            $data = json_decode(file_get_contents("php://input"), true);
            $this->validateRequiredFields($data, ['email', 'image_url']);
            $image = $data['image_url'];
            $info = [
                'image_id' => uniqid(),
                'image_url' => $image,
                'image_type' => 'profile_pic',
            ];
            if($this->imagemodel->create($info)) {
                $this->userModel->profile_pic_update($data['email'], $info['image_id']);
                
                $this->sendResponse(201, "Profile Picture Changed");
                return;
            }
            else
            {
                $this->sendResponse(500, "Failed to upload image");
            }

        } catch (PDOException $e){
            $this->sendResponse(500, 'Error uploading image');
        }
    }


}


?>