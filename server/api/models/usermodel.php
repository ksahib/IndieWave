<?php
include_once 'basemodel.php';
class Usermodel extends BaseModel{
    public function __construct($db)
    {
        parent::__construct($db);
        $this->table_name = 'users';
    }
    

    public function profile_pic_update($id, $data) {

        $query = "UPDATE users SET profile_pic = :image WHERE email = :email";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(":email", $id);
        $stmt->bindParam(":image", $data);
        if ($stmt->execute()) {
            return ['status' => 200, 'message' => 'Record updated successfully'];
        } else {
            return ['status' => 500, 'message' => 'Error updating record'];
        }
    }
}


?>