<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/config/database.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/followmodel.php';

include_once 'BaseController.php';

class Follow extends BaseController {
    private $followModel;

    public function __construct($db) {
        parent::__construct($db);
        $this->followModel = new followmodel($this->db);
    }

    public function create() {
        try{

            $data = json_decode(file_get_contents("php://input"), true);
        
            $this->validateRequiredFields($data, ['email', 'artist_name']);
        
            if ($this->followModel->create($data)) {
                $this->sendResponse(201, 'User followed artist.');
            } else {
                $this->sendResponse(500, 'Error following');
            }
        } catch (Exception $e){
            $this->sendResponse(500, 'Error');
        }
    }


}


?>