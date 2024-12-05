<?php
include_once 'basemodel.php';
class playlistmodel extends BaseModel{
    public function __construct($db)
    {
        parent::__construct($db);
        $this->table_name = 'playlists';
    }

    public function getplaylist($email, $name) {
        $query = "
            SELECT * 
            FROM " . $this->table_name . "
            WHERE email = :email AND name = :name
        ";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(":name", $name);
        $stmt->bindParam(":email", $email);
        $stmt->execute();

        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        return $row;
    }
    
}


?>