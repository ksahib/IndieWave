<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/config/database.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/trackModel.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/queueModel.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/imageModel.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/playlistModel.php';
include_once 'BaseController.php';

class QueueAutoPlay extends BaseController {
    private $trackModel;
    private $queueModel;
    private $imageModel;
    private $playlistModel;
    public function __construct($db) {
        parent::__construct($db);
        $this->trackModel = new trackModel($this->db);
        $this->queueModel = new queueModel($this->db);
        $this->imageModel = new imageModel($this->db);
        $this->playlistModel = new playlistModel($this->db);
    }

    public function create() {
        $data = json_decode(file_get_contents("php://input"), true);
        // Validate required fields 
        $this->validateRequiredFields($data, ['track-id', 'email']);
        $trackHint = $data['track-id'];
        $user = $data['email'];
            
        try {
            if (empty($trackHint))
                $trackHint = "";
            // Fetch genres based on the hint
            $query = "SELECT * FROM tracks WHERE track_id = :hint";
            $stmt = $this->db->prepare($query);
            $searchTerm = $trackHint;
            //binds to %hint% to ? in query
            $stmt->bindParam(":hint", $searchTerm);
            $stmt->execute();
            $curtrack = $stmt->fetchAll(PDO::FETCH_ASSOC);
            
            $query = "SELECT track_id, track_name, tag, track_url, album_id FROM tracks NATURAL JOIN streams WHERE track_id != :hint2 GROUP BY track_id ORDER BY RAND()*COUNT(*) DESC LIMIT 50";
            $stmt = $this->db->prepare($query);
            $stmt->bindParam(":hint2", $searchTerm);
            $stmt->execute();
            $result = $stmt->fetchAll(PDO::FETCH_ASSOC);

            //playlist create
            $pin = [ 'cover_pic' => 'default', 'playlist_id' => $user, 'name' => $user, 'email' => $user];

            $imageid = uniqid();
            $info = [
                'image_id' => $imageid,
                'image_url' => isset($pin['cover_pic']) ? $pin['cover_pic'] : 'default',
                'image_type' => 'cover_pic'
            ];
            if($this->imageModel->create($info))
            {
                $pin['cover_pic'] = $imageid;
            }
            else
            {
                $this->sendResponse(500, "Failed to upload image");
                return;
            }
            if (!$this->playlistModel->create($pin)) { 
                $this->sendResponse(500, "Failed to create playlist"); 
                return;
            }
            
            $qin = [
                'track_id' => $trackHint,
                'playlist_id' => $pin['playlist_id']
            ];
            if (!$this->queueModel->create($qin)){
                $this->sendResponse(500, "Failed to add track to queue");
                return;
            }

            foreach ($result as $row) { 
                $qin['track_id'] = $row['track_id'];
                if (!$this->queueModel->create($qin)){
                    $this->sendResponse(500, "Failed to add track to queue");
                    return;
                } 
            }
            $result = array_merge($curtrack, $result);
            
            if (!empty($result))
                $this->sendResponse(200, 'retrieved track are', $result);
            else
                $this->sendResponse(401, 'Error no track autoqueue');

        } catch (Exception $e) {
            $this->sendResponse(401, 'Error');
        }
    }
}

?>
