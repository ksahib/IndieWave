<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Credentials: true");
header("Access-Control-Allow-Headers: Content-Type");

require_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/vendor/autoload.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/config/database.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/AlbumModel.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/imagemodel.php';
include_once 'BaseController.php';

class AllReleasedAlbum extends BaseController {
    private $albumModel;

    public function __construct($db) {
        parent::__construct($db);
        $this->albumModel = new AlbumModel($this->db);
    }

    public function _get() {
        $headers = apache_request_headers();
        $artistName = $headers['artist-name'];

        try {
            if (!$artistName) {
                $this->sendResponse(401, 'No valid token found');
                return;
            }

            $albums = $this->albumModel->getReleasedAlbumsByArtist($artistName);

            if ($albums['status'] === 200) {
                $this->sendResponse(200, 'Albums retrieved successfully', $albums['data']);
            } else {
                $this->sendResponse(404, 'No albums found');
            }

        } catch (Exception $e) {
            http_response_code(500);
            echo json_encode(["error" => $e->getMessage()]);
        }
    }
}

?>
