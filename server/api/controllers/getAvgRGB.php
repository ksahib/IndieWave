<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Credentials: true");
header("Access-Control-Allow-Headers: Content-Type");

require_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/vendor/autoload.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/config/database.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/imagemodel.php';

include_once 'BaseController.php';

class getAvgRGB extends BaseController {
    private $imagemodel;

    public function __construct($db) {
        parent::__construct($db); 
        $this->imagemodel = new imagemodel($this->db);
    }

    public function _get() {
        $headers = apache_request_headers();
        $imagehd = $headers['image-id'];
        try {
            if(!$imagehd) {
                $this->sendResponse(401, 'No valid token found');
                return;
            }

            $image = $this->imagemodel->get("image_id", $imagehd);

            $image['R'] = null;
            $image['G'] = null;
            $image['B'] = null;

            $imageData = file_get_contents($image['data']['image_url']);

            if ($imageData !== false){
                $imageRGB = imagecreatefromstring($imageData);

                if ($imageRGB !== false) {
                    $width = imagesx($imageRGB);
                    $height = imagesy($imageRGB);
                    $rSum = 0;
                    $gSum = 0;
                    $bSum = 0;
                    
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
                    $image['R'] = $rSum / ($width * $height);
                    $image['G'] = $gSum / ($width * $height);
                    $image['B'] = $bSum / ($width * $height);
                } 
            }
            
            $this->sendResponse(200, 'Retrieved inage RGB data', [$image['R'], $image['G'], $image['B']]);
        }  catch(Exception $e)  {
            http_response_code(500);
            echo json_encode(["error" => $e->getMessage()]);
        }
        
    }  
    

}
?>