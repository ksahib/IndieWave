<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/config/database.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/queuemodel.php';

include_once 'BaseController.php';

class QueueAdd extends BaseController {
    private $queueModel;

    public function __construct($db) {
        parent::__construct($db);
        $this->queueModel = new queuemodel($this->db);
    }

    public function create() {
        try{

            $data = json_decode(file_get_contents("php://input"), true);
        
            $this->validateRequiredFields($data, ['track_id', 'playlist_id']);
        
            if ($this->queueModel->create($data)) {
                $this->sendResponse(201, 'track added');
            } else {
                $this->sendResponse(500, 'Error adding');
            }
        } catch (Exception $e){
            $this->sendResponse(500, 'Error');
        }
    }


}


?>