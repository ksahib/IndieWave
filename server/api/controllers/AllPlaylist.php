<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Credentials: true");
header("Access-Control-Allow-Headers: Content-Type");

require_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/vendor/autoload.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/config/database.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/playlistModel.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/queueModel.php';

include_once 'BaseController.php';

class AllPlaylist extends BaseController {
    private $playlistModel;

    public function __construct($db) {
        parent::__construct($db);
        $this->playlistModel = new playlistModel($this->db);
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
            if (!empty($result))
                $this->sendResponse(200, 'retrieved playlists are', $result);
            else
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
