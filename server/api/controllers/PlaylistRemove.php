<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/config/database.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/playlistmodel.php';

include_once 'BaseController.php';

class PlaylistRemove extends BaseController {
    private $playlistModel;

    public function __construct($db) {
        parent::__construct($db);
        $this->playlistModel = new playlistmodel($this->db);
    }

    public function _get() {
        $headers = apache_request_headers();
        //$email = $headers['email'];
        $pl_id = $headers['playlist-id'];
        
        

        try {
            if(!$pl_id) {
                $this->sendResponse(401, 'playlist_id not valid');
                return;
            }
            
            $this->playlistModel->delete("playlist_id", $pl_id);
            
            $this->sendResponse(200, 'Unplaylisted succesfully');
        }  catch(Exception $e)  {
            http_response_code(500);
            echo json_encode(["error" => $e->getMessage()]);
        }
    }


}


?>