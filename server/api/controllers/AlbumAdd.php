<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/config/database.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/albumModel.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/imagemodel.php';

include_once 'BaseController.php';

class AlbumAdd extends BaseController {
    private $albumModel;
    private $imageModel;

    public function __construct($db) {
        parent::__construct($db);
        $this->albumModel = new albummodel($this->db);
        $this->imageModel = new imagemodel($this->db);
    }

    public function create() {
        try{
            // Get input data
            $data = json_decode(file_get_contents("php://input"), true);
        
            // Validate required fields 
            $this->validateRequiredFields($data, ['name', 'price', 'artist_name']);
            
            // Set default values for fields that are not provided
            if($data['cover_art'] === '') {
                $data['cover_art'] = 'default';
            }
            $imageid = uniqid();
            $info = [
                'image_id' => $imageid,
                'image_url' => $data['cover_art'],
                'image_type' => 'cover_art',
            ];
            if($this->imageModel->create($info))
            {
                $data['cover_art'] = $imageid;
            }
            else
            {
                $this->sendResponse(500, "Failed to upload image");
                echo json_encode(['images'=>$info]);
            }
            $data['album_id'] = uniqid();

            // Call the ArtistModel's create method to insert into the database
            if ($this->albumModel->create($data)) {
                $this->sendResponse(201, 'New Album created successfully.');
            } else {
                $this->sendResponse(500, 'Failed to create Album');
            }
        } catch (Exception $e){
            $this->sendResponse(500, 'Album already exists');
        }
    }


}


?>