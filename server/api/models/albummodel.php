<?php
include_once 'basemodel.php';
class albummodel extends BaseModel {
    public function __construct($db) {
        parent::__construct($db);
        $this->table_name = 'album';
    }

    public function getAlbumsByArtist($artistName) {
        $query = "
            SELECT a.*, i.image_url 
            FROM " . $this->table_name . " a
            LEFT JOIN images i ON a.cover_art = i.image_id
            WHERE a.artist_name = :artist_name
        ";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(":artist_name", $artistName);
        $stmt->execute();

        $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        
        if ($rows) {
            
            foreach ($rows as &$album) {
                if (isset($album['image_url'])) {
                    $album['cover_art'] = $album['image_url']; 
                    unset($album['image_url']); 
                }
            }

            return ['status' => 200, 'data' => $rows];
        } else {
            return ['status' => 404, 'message' => 'No albums found'];
        }
    }
}



?>