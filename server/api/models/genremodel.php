<?php
include_once 'basemodel.php';
class genremodel extends BaseModel{
    public function __construct($db)
    {
        parent::__construct($db);
        $this->table_name = 'genre';
    }
    
}

?>