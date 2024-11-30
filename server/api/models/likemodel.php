<?php
include_once 'basemodel.php';
class likemodel extends BaseModel{
    public function __construct($db)
    {
        parent::__construct($db);
        $this->table_name = 'likes';
    }

    public function getLike($email, $track_id) {
        $query = "
            SELECT * 
            FROM " . $this->table_name . "
            WHERE email = :email AND track_id = :track_id
        ";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(":email", $email);
        $stmt->bindParam(":track_id", $track_id);
        $stmt->execute();

        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        return $row;
    }

    public function delete($email, $track) {
        $query = "DELETE FROM " . $this->table_name . " WHERE email = :email AND track_id = :track";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(":email", $email);
        $stmt->bindParam(":track", $track);

        if ($stmt->execute()) {
            return ['status' => 200, 'message' => 'Record deleted successfully'];
        } else {
            return ['status' => 500, 'message' => 'Error deleting record'];
        }
    }
    
}


?>
