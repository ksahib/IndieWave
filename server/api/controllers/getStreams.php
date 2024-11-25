<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/config/database.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/streamsmodel.php';

include_once 'BaseController.php';

class getStreams extends BaseController {
    private $streamModel;

    public function __construct($db) {
        parent::__construct($db);
        $this->streamModel = new streamsModel($this->db);
    }

    public function _get() {
        $headers = apache_request_headers();
        $track = $headers['track-id'];

        try {
            if (empty($track))
                throw new Exception('Track is empty');
            // Fetch genres based on the hint
            $query = "SELECT COUNT(*) as streams FROM streams WHERE track_id = :track";
            $stmt = $this->db->prepare($query);
        
            //binds to %hint% to ? in query
            $stmt->bindParam(":track", $track);

            if ($stmt->execute()) {
                $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
            if (!empty($result))
                $this->sendResponse(200, 'total streams are', $result);
            else
                $this->sendResponse(401, 'error in query');
            } else {
                $this->sendResponse(401, 'Error occured');
            }

        } catch (Exception $e) {
            $this->sendResponse(401, 'Error');
        }
    }


}


?>