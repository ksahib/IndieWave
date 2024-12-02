<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/config/database.php';
include_once $_SERVER['DOCUMENT_ROOT'] . '/indiewave/api/models/imagemodel.php';
include_once 'BaseController.php';

class Banner extends BaseController {
    private $imagemodel;
    public function __construct($db) {
        parent::__construct($db);
        $this->imagemodel = new imagemodel($this->db);
    }

    public function _get() {
        $headers = apache_request_headers();
        $email = $headers['email'];
        try {
        
            if (!$email) {
                $this->sendResponse(400, 'Bad request');
                exit;
            }

            $query_user_feed = "
            SELECT 
                uf.artist_name, 
                a.cover_art, 
                a.name 
            FROM 
                user_feed uf
            JOIN 
                album a ON uf.album_id = a.album_id
            JOIN 
                released r ON r.album_id = a.album_id
            WHERE 
                uf.email = :email
            ORDER BY 
                (uf.followers + uf.likes + uf.streams) DESC, r.release_date DESC
            LIMIT 1
        ";
        
            $query_default = "
                SELECT 
                    f.artist_name, 
                    a.cover_art, 
                    a.name
                FROM 
                    feed f
                JOIN 
                    album a ON f.album_id = a.album_id
                ORDER BY 
                    (f.followers + f.likes + f.streams) DESC, f.release_date DESC
                LIMIT 1
            ";
        
            $stmt = $this->db->prepare($query_user_feed);
            $stmt->bindParam(':email', $email);
            $stmt->execute();
            $album = $stmt->fetch(PDO::FETCH_ASSOC);
        
            if (!$album) {
                $stmt_default = $this->db->prepare($query_default);
                $stmt_default->execute();
                $album = $stmt_default->fetch(PDO::FETCH_ASSOC);
            }
        
            if ($album) {
                if($image = $this->imagemodel->get("image_id", $album["cover_art"])) {
                    $album["cover_art"] = $image["data"]["image_url"];
                }
                $this->sendResponse(200, 'Retrieved banner', $album);
            } else {
                $this->sendResponse(401, 'Error fetching banner' );
            }
        } catch (Exception $e) {
            $this->sendResponse(500, 'Internal server error: ' . $e->getMessage()); // Internal Server Error
        }
        
    }

}
?>
