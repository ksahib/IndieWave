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
            $query = "SELECT * FROM users WHERE email = :hint";
            $stmt = $this->db->prepare($query);

            $searchTerm = $data['email'];
        
            //binds to %hint% to ? in query
            $stmt->bindParam(":hint", $searchTerm);
            if ($stmt->execute())
                $result = $stmt->fetch(PDO::FETCH_ASSOC);
            
            $query = "UPDATE images SET image_url = :iurl WHERE image_id = :hint";
            $stmt = $this->db->prepare($query);

            $searchTerm = $result['profile_pic'];
        
            //binds to %hint% to ? in query
            $stmt->bindParam(":hint", $searchTerm);
            $stmt->bindParam(":iurl", $data['image_url']);
            
            
            if($stmt->execute()) {
                $result = $stmt->fetch(PDO::FETCH_ASSOC);
                $this->sendResponse(201, "Profile Picture Changed");
            }
            else
            {
                $this->sendResponse(505, "Error");
                return;
            }

        } catch (PDOException $e){
            $this->sendResponse(500, $e);
        }
    }


}


?>