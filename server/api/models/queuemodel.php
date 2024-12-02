<?php
include_once 'basemodel.php';
class queuemodel extends BaseModel{
    public function __construct($db)
    {
        parent::__construct($db);
        $this->table_name = 'queue';
    }
    
    public function delete($playlist, $track) {
        $query = "DELETE FROM " . $this->table_name . " WHERE track_id = :track AND playlist_id = :playlist";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(":track", $track);
        $stmt->bindParam(":playlist", $playlist);

        if ($stmt->execute()) {
            return ['status' => 200, 'message' => 'Record deleted successfully'];
        } else {
            return ['status' => 500, 'message' => 'Error deleting record'];
        }
    }
}


?>