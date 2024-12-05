<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/config/database.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/playlistModel.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/imagemodel.php';

include_once 'BaseController.php';

class PlaylistAdd extends BaseController {
    private $playlistModel;
    private $imageModel;

    public function __construct($db) {
        parent::__construct($db);
        $this->playlistModel = new playlistmodel($this->db);
        $this->imageModel = new imagemodel($this->db);
    }

    public function create() {
        try{
            // Get input data
            $data = json_decode(file_get_contents("php://input"), true);
        
            // Validate required fields 
            $this->validateRequiredFields($data, ['name', 'email']);
            
            // Set default values for fields that are not provided
            if(!isset($data['cover_pic']) || $data['cover_pic'] === '') {
                $data['cover_pic'] = 'default';
            }
            $imageid = uniqid();
            $info = [
                'image_id' => $imageid,
                'image_url' => $data['cover_pic'],
                'image_type' => 'cover_pic',
            ];
            if($this->imageModel->create($info))
            {
                $data['cover_pic'] = $imageid;
            }
            else
            {
                $this->sendResponse(500, "Failed to upload image");
                echo json_encode(['images'=>$info]);
            }
            $data['playlist_id'] = uniqid();

            // Call the ArtistModel's create method to insert into the database
            if ($this->playlistModel->create($data)) {
                $this->sendResponse(201, 'New Playlist created successfully.');
            } else {
                $this->sendResponse(500, 'Failed to create Playlist');
            }
        } catch (Exception $e){
            $this->sendResponse(500, 'Error');
        }
    }


}


?>