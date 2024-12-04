<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Credentials: true");
header("Access-Control-Allow-Headers: Content-Type");

require_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/vendor/autoload.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/config/database.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/playlistModel.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/queueModel.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/imageModel.php';


include_once 'BaseController.php';
include_once 'getAvgRGB.php';


class AllPlaylist extends BaseController {
    private $playlistModel;
    private $imagemodel;
    

    public function __construct($db) {
        parent::__construct($db);
        $this->playlistModel = new playlistModel($this->db);
        $this->imagemodel = new imageModel($this->db);
        
    }

    public function _get() {
        $headers = apache_request_headers();
        $Hint = $headers['email'];

        try {
            if (empty($Hint))
                $Hint = "";
            // Fetch genres based on the hint
            $query = "SELECT playlist_id, email, name, image_url as cover_pic FROM playlists JOIN images ON playlists.cover_pic = images.image_id WHERE email = :hint AND playlist_id != :hint
                        GROUP BY playlist_id";
            $stmt = $this->db->prepare($query);

            $searchTerm = $Hint;
        
            //binds to %hint% to ? in query
            $stmt->bindParam(":hint", $searchTerm);

            if ($stmt->execute()) {
                $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
            if (!empty($result)){
                foreach ($result as &$playlist) {
                    $image = $this->imagemodel->get("image_url", $playlist['cover_pic']);

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
                    $playlist['R'] = $image['R'];
                    $playlist['G'] = $image['G'];
                    $playlist['B'] = $image['B'];

                }
                $this->sendResponse(200, 'retrieved playlists are', $result);
            }else
                $this->sendResponse(401, 'No playlist found');
            } else {
                $this->sendResponse(401, 'Error occured');
            }

        } catch (Exception $e) {
            $this->sendResponse(401, 'Error');
        }
    }
}

?>
