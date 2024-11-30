<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Credentials: true");
header("Access-Control-Allow-Headers: Content-Type");

require_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/vendor/autoload.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/config/database.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/genreModel.php';
include_once 'BaseController.php';

class GetGenre extends BaseController {
    private $genreModel;

    public function __construct($db) {
        parent::__construct($db);
        $this->genreModel = new GenreModel($this->db);
    }

    public function _get() {
        $headers = apache_request_headers();
        $genreHint = $headers['genre-hint'];

        try {
            if (empty($genreHint))
                $genreHint = "";
            // Fetch genres based on the hint
            $query = "SELECT * FROM genre WHERE tag LIKE :hint";
            $stmt = $this->db->prepare($query);

            $searchTerm = $genreHint . "%";
        
            //binds to %hint% to ? in query
            $stmt->bindParam(":hint", $searchTerm);

            if ($stmt->execute()) {
                $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
            if (!empty($result))
                $this->sendResponse(200, 'retrieved genre are', $result);
            else
                $this->sendResponse(401, 'No genre matched');
            } else {
                $this->sendResponse(401, 'Error occured');
            }

        } catch (Exception $e) {
            $this->sendResponse(401, 'Error');
        }
    }
}

?>
