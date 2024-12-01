<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Credentials: true");
header("Access-Control-Allow-Headers: Content-Type");

require_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/vendor/autoload.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/config/database.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/artistModel.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/albumModel.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/trackModel.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/feedModel.php';
include_once 'BaseController.php';

class Search extends BaseController {
    private $artistModel;
    private $albumModel;
    private $trackModel;
    private $feedModel;

    public function __construct($db) {
        parent::__construct($db);
        $this->artistModel = new ArtistModel($this->db);
        $this->albumModel = new AlbumModel($this->db);
        $this->trackModel = new trackModel($this->db);
        $this->feedModel = new feedModel($this->db);
    }

    public function _get() {
        $headers = apache_request_headers();
        $Hint = $headers['hint'];

        try {
            if (empty($Hint))
                $Hint = "";
            // Fetch genres based on the hint
            $query = "SELECT track_name FROM feed NATURAL JOIN tracks NATURAL JOIN album WHERE track_name LIKE :hint AND track_id IN (SELECT track_id FROM feed)
                      GROUP BY (track_name)";
            $stmt = $this->db->prepare($query);

            $searchTerm = $Hint . "%";
        
            //binds to %hint% to ? in query
            $stmt->bindParam(":hint", $searchTerm);
            $stmt->execute();
            $tracks = $stmt->fetchAll(PDO::FETCH_ASSOC);

            $query = "SELECT album.name FROM feed NATURAL JOIN tracks NATURAL JOIN album WHERE album.name LIKE :hint AND album_id IN (SELECT album_id FROM feed)
                      GROUP BY (album.name)";
            $stmt = $this->db->prepare($query);

            $searchTerm = $Hint . "%";
        
            //binds to %hint% to ? in query
            $stmt->bindParam(":hint", $searchTerm);
            $stmt->execute();
            $albums = $stmt->fetchAll(PDO::FETCH_ASSOC);
            
            $query = "SELECT artist_name FROM feed NATURAL JOIN tracks NATURAL JOIN album WHERE artist_name LIKE :hint AND artist_name IN (SELECT artist_name FROM feed)
                      GROUP BY (artist_name)";
            $stmt = $this->db->prepare($query);

            $searchTerm = $Hint . "%";
        
            //binds to %hint% to ? in query
            $stmt->bindParam(":hint", $searchTerm);
            $stmt->execute();
            $artists = $stmt->fetchAll(PDO::FETCH_ASSOC);
            $result = array_merge($tracks, $albums, $artists);

            if (!empty($result))
                $this->sendResponse(200, 'retrieved tracks, albums and artists are', $result);
            else
                $this->sendResponse(401, 'No track matched');
            

        } catch (Exception $e) {
            $this->sendResponse(401, 'Error');
        }
    }
}

?>
