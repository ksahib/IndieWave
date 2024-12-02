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
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/imagemodel.php';
include_once 'BaseController.php';

class Search extends BaseController {
    private $artistModel;
    private $albumModel;
    private $trackModel;
    private $imagemodel;
    private $feedModel;

    public function __construct($db) {
        parent::__construct($db);
        $this->artistModel = new ArtistModel($this->db);
        $this->albumModel = new AlbumModel($this->db);
        $this->trackModel = new trackModel($this->db);
        $this->feedModel = new feedModel($this->db);
        $this->imagemodel = new imagemodel($this->db);
    }

    public function _get() {
        $headers = apache_request_headers();
        $Hint = isset($headers['hint']) ? $headers['hint'] : "";
        $type = isset($headers['type']) ? $headers['type'] : "";

        try {

            $searchTerm = $Hint . "%";
            $tracks = [];
            if($type === 'tracks' || $type === 'all')
            {
                $query = "SELECT 
                        tracks.track_id, 
                        tracks.track_name, 
                        tracks.track_url,
                        album.album_id, 
                        album.name AS album_name, 
                        images.image_url as album_cover 
                      FROM feed 
                      NATURAL JOIN tracks 
                      NATURAL JOIN album 
                      NATURAL JOIN images
                      WHERE tracks.track_name LIKE :hint 
                      AND track_id IN (SELECT track_id FROM feed)
                      AND album.cover_art = images.image_id 
                      GROUP BY tracks.track_id";
                $stmt = $this->db->prepare($query);
                $stmt->bindParam(":hint", $searchTerm);
                $stmt->execute();
                $tracks = $stmt->fetchAll(PDO::FETCH_ASSOC);
            }

            $albums = [];
            if($type === 'albums' || $type === 'all') {
                $query = "SELECT 
                        album.album_id, 
                        album.name, 
                        images.image_url AS cover_art, 
                        artist.artist_name 
                      FROM feed 
                      NATURAL JOIN tracks 
                      NATURAL JOIN album 
                      NATURAL JOIN images
                      NATURAL JOIN artist 
                      WHERE album.name LIKE :hint 
                      AND album_id IN (SELECT album_id FROM feed)
                      AND album.cover_art = images.image_id 
                      GROUP BY album.album_id";
                $stmt = $this->db->prepare($query);
                $stmt->bindParam(":hint", $searchTerm);
                $stmt->execute();
                $albums = $stmt->fetchAll(PDO::FETCH_ASSOC);
            }

            $artists = [];
            if($type === 'artists' || $type === 'all')
            {
                $query = "SELECT  
                        artist.artist_name, 
                        artist.about, 
                        images.image_url AS profile_pic,
                        feed.followers 
                      FROM feed 
                      NATURAL JOIN tracks 
                      NATURAL JOIN album 
                      NATURAL JOIN artist 
                      NATURAL JOIN images
                      WHERE artist.artist_name LIKE :hint 
                      AND artist_name IN (SELECT artist_name FROM feed) 
                      AND artist.profile_pic = images.image_id
                      GROUP BY artist.artist_name";
                $stmt = $this->db->prepare($query);
                $stmt->bindParam(":hint", $searchTerm);
                $stmt->execute();
                $artists = $stmt->fetchAll(PDO::FETCH_ASSOC);
            }

            $result = [
                'tracks' => $tracks,
                'albums' => $albums,
                'artists' => $artists
            ];

            if (!empty($result['tracks']) || !empty($result['albums']) || !empty($result['artists'])) {
                $this->sendResponse(200, 'Results retrieved successfully', $result);
            } else {
                $this->sendResponse(404, 'No matches found');
            }

        } catch (Exception $e) {
            $this->sendResponse(500, 'Error occurred: ' . $e->getMessage());
        }
    }
}
?>
