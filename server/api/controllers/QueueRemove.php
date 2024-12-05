<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/config/database.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/queuemodel.php';

include_once 'BaseController.php';

class QueueRemove extends BaseController {
    private $queueModel;

    public function __construct($db) {
        parent::__construct($db);
        $this->queueModel = new queuemodel($this->db);
    }

    public function _get() {
        $headers = apache_request_headers();
        $playlist = $headers['playlist_id'];
        $track = $headers['track_id'];
        
        

        try {
            if(!$playlist || !$track) {
                $this->sendResponse(401, 'Playlist/Track not valid');
                return;
            }
    
            $this->queueModel->delete($playlist, $track);
            
            $this->sendResponse(200, 'Remove succesfully');
        }  catch(Exception $e)  {
            http_response_code(500);
            echo json_encode(["error" => $e->getMessage()]);
        }
    }


}


?>