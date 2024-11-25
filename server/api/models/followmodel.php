<?php
include_once 'basemodel.php';
class followmodel extends BaseModel{
    public function __construct($db)
    {
        parent::__construct($db);
        $this->table_name = 'follows';
    }

    public function getFollow($artist_name, $email) {
        $query = "
            SELECT * 
            FROM " . $this->table_name . "
            WHERE email = :email AND artist_name = :artist_name
        ";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(":email", $email);
        $stmt->bindParam(":artist_name", $artist_name);
        $stmt->execute();

        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        return $row;
    }

    public function delete($email, $artist_name) {
        $query = "DELETE FROM " . $this->table_name . " WHERE email = :email AND artist_name = :artist_name";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(":email", $email);
        $stmt->bindParam(":artist_name", $artist_name);

        if ($stmt->execute()) {
            return ['status' => 200, 'message' => 'Record deleted successfully'];
        } else {
            return ['status' => 500, 'message' => 'Error deleting record'];
        }
    }
    
}


?>
