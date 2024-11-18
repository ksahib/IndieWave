<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Credentials: true");
header("Access-Control-Allow-Headers: Content-Type");

require_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/vendor/autoload.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/config/database.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/trackModel.php';
include_once 'BaseController.php';

class GetTrack extends BaseController {
    private $trackModel;

    public function __construct($db) {
        parent::__construct($db);
        $this->trackModel = new TrackModel($this->db);
    }

    public function _get() {
        $headers = apache_request_headers();
        $trackHint = $headers['album-id'];

        try {
            if (empty($trackHint))
                $trackHint = "";
            // Fetch genres based on the hint
            $query = "SELECT * FROM tracks WHERE album_id = :hint";
            $stmt = $this->db->prepare($query);

            $searchTerm = $trackHint;
        
            //binds to %hint% to ? in query
            $stmt->bindParam(":hint", $searchTerm);

            if ($stmt->execute()) {
                $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
            if (!empty($result))
                $this->sendResponse(200, 'retrieved track are', $result);
            else
                $this->sendResponse(401, 'No track found');
            } else {
                $this->sendResponse(401, 'Error occured');
            }

        } catch (Exception $e) {
            $this->sendResponse(401, 'Error');
        }
    }
}

?>
