<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Credentials: true");
header("Access-Control-Allow-Headers: Content-Type");

require_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/vendor/autoload.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/config/database.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/imageModel.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/albumModel.php';

include_once 'BaseController.php';

class InPlaylist extends BaseController {
    private $imageModel;
    private $albumModel;

    public function __construct($db) {
        parent::__construct($db);
        $this->imageModel = new imagemodel($this->db);
        $this->albumModel = new albummodel($this->db);
    }

    public function _get() {
        $headers = apache_request_headers();
        $trackHint = $headers['playlist-id'];
    
        try {
            if (empty($trackHint)) {
                $this->sendResponse(400, 'Playlist ID is missing');
                return;
            }
    
            $query = "SELECT track_id, track_name, track_url, tag, album_id AS cover_art  
                      FROM tracks 
                      WHERE track_id IN (SELECT track_id FROM queue WHERE playlist_id = :hint)";
            $stmt = $this->db->prepare($query);
            $stmt->bindParam(":hint", $trackHint);
    
            if ($stmt->execute()) {
                $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
                if (!empty($result)) {
                    foreach ($result as &$track) {
                        $albumCover = $this->albumModel->get("album_id", $track["cover_art"]);
                        if (!$albumCover || !isset($albumCover["data"])) {
                            $track["cover_art"] = null;
                            continue;
                        }
    
                        $image = $this->imageModel->get("image_id", $albumCover["data"]["cover_art"]);
                        $track["cover_art"] = $image && isset($image["data"]) ? $image["data"]["image_url"] : null;
                    }
    
                    $this->sendResponse(200, 'Tracks retrieved successfully', $result);
                } else {
                    $this->sendResponse(404, 'No tracks found');
                }
            } else {
                $this->sendResponse(500, 'Database query error');
            }
        } catch (Exception $e) {
            $this->sendResponse(500, 'Server error: ' . $e->getMessage());
        }
    }
    
}

?>
