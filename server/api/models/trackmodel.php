<?php
include_once 'basemodel.php';
class trackmodel extends BaseModel{
    public function __construct($db)
    {
        parent::__construct($db);
        $this->table_name = 'tracks';
    }
    
}

?>