<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Credentials: true");
header("Access-Control-Allow-Headers: Content-Type");

require_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/vendor/autoload.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/config/database.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/AlbumModel.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/genremodel.php';
include_once 'BaseController.php';

class Genre extends BaseController {
    private $genreModel;

    public function __construct($db) {
        parent::__construct($db);
        $this->genreModel = new genremodel($this->db);
    }

    public function _get() {

        try {

            $genre = $this->genreModel->getAll();

            if ($genre['status'] === 200) {
                $this->sendResponse(200, 'Genres retrieved successfully', $genre['data']);
            } else {
                $this->sendResponse(404, 'No genres found');
            }

        } catch (Exception $e) {
            http_response_code(500);
            echo json_encode(["error" => $e->getMessage()]);
        }
    }
}

?>
