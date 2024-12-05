<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Credentials: true");
header("Access-Control-Allow-Headers: Content-Type");

require_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/vendor/autoload.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/config/database.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/playlistmodel.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/imagemodel.php';

include_once 'BaseController.php';

class getplaylist extends BaseController {
    private $playlistModel;
    private $imagemodel;

    public function __construct($db) {
        parent::__construct($db); 
        $this->playlistModel = new playlistmodel($this->db);
        $this->imagemodel = new imagemodel($this->db);
    }

    public function _get() {
        $headers = apache_request_headers();
        $user = $headers['email'];
        $playlistName =$headers['playlist-name'];
        

        try {
            if(!$user || !$playlistName) {
                $this->sendResponse(401, 'No valid token found');
                return;
            }
    
                
            $playlist = $this->playlistModel->getplaylist($user, $playlistName);
            $image = $this->imagemodel->get("image_id", $playlist['cover_pic']);
            $playlist['cover_pic'] = $image['data']['image_url'];
            if(!$playlist) {
                $this->sendResponse(401, 'Playlist not found');
                return;
            }

            $playlist['R'] = null;
            $playlist['G'] = null;
            $playlist['B'] = null;

            $imageData = file_get_contents($playlist['cover_pic']);

            if ($imageData !== false){
                $imageRGB = imagecreatefromstring($imageData);

                if ($imageRGB !== false) {
                    $width = imagesx($imageRGB);
                    $height = imagesy($imageRGB);
                    $rSum = 0;
                    $gSum = 0;
                    $bSum = 0;
                    
                    // Iterate through each pixel
                    for ($x = 0; $x < $width; $x++) {
                        for ($y = 0; $y < $height; $y++) {
                            $rgb = imagecolorat($imageRGB, $x, $y);
                            $r = ($rgb >> 16) & 0xFF; // Red component
                            $g = ($rgb >> 8) & 0xFF;  // Green component
                            $b = $rgb & 0xFF;         // Blue component
                            $rSum += $r;
                            $gSum += $g;
                            $bSum += $b;
                            
                        }
                    }
                    $playlist['R'] = $rSum / ($width * $height);
                    $playlist['G'] = $gSum / ($width * $height);
                    $playlist['B'] = $bSum / ($width * $height);
                } 
            }
            $this->sendResponse(200, 'Retrieved playlist data', [$playlist]);
        }  catch(Exception $e)  {
            http_response_code(500);
            echo json_encode(["error" => $e->getMessage()]);
        }
        
    }  
    

}
?>