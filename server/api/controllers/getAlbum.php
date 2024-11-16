<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Credentials: true");
header("Access-Control-Allow-Headers: Content-Type");

require_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/vendor/autoload.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/config/database.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/albummodel.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/imagemodel.php';

include_once 'BaseController.php';

class getAlbum extends BaseController {
    private $albumModel;
    private $imagemodel;

    public function __construct($db) {
        parent::__construct($db); 
        $this->albumModel = new albummodel($this->db);
        $this->imagemodel = new imagemodel($this->db);
    }

    public function _get() {
        $headers = apache_request_headers();
        $artistName = $headers['artist-name'];
        $albumName =$headers['album-name'];
        

        try {
            if(!$artistName || !$albumName) {
                $this->sendResponse(401, 'No valid token found');
                return;
            }
    
    
            $album = $this->albumModel->getAlbum($artistName, $albumName);
            $image = $this->imagemodel->get("image_id", $album['cover_art']);
            $album['cover_art'] = $image['data']['image_url'];
            if(!$album) {
                $this->sendResponse(401, 'User not found');
                return;
            }
            
            $this->sendResponse(200, 'Retrieved album data', [$album]);
        }  catch(Exception $e)  {
            http_response_code(500);
            echo json_encode(["error" => $e->getMessage()]);
        }
        
    }  
    

}
?>