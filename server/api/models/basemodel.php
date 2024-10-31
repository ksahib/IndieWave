<?php
class BaseModel {
    protected $conn;
    protected $table_name;

    public function __construct($db) {
        $this->conn = $db;
    }

    // Create a new record
    public function create($data) {
        $fields = implode(", ", array_keys($data));
        $placeholders = ":" . implode(", :", array_keys($data));

        $query = "INSERT INTO " . $this->table_name . " ($fields) VALUES ($placeholders)";
        $stmt = $this->conn->prepare($query);

        foreach ($data as $field => $value) {
            $stmt->bindValue(":$field", $value);
        }

        if ($stmt->execute()) {
            return ['status' => 201, 'message' => 'Record created successfully'];
        } else {
            $errorInfo = $stmt->errorInfo();
            return ['status' => 500, 'message' => 'Error creating record: ' . implode(", ", $errorInfo)];
        }
    }

    // Get a single record
    public function get($column, $id) {
        if (!preg_match('/^[a-zA-Z_]+$/', $column)) {
            return ['status' => 400, 'message' => 'Invalid column name'];
        }
        $query = "SELECT * FROM " . $this->table_name . " WHERE $column = :id";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(":id", $id);
        $stmt->execute();

        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        if ($row) {
            return ['status' => 200, 'data' => $row];
        } else {
            return ['status' => 404, 'message' => 'Record not found'];
        }
    }

    // Get all records
    public function getAll() {
        $query = "SELECT * FROM " . $this->table_name;
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

        return ['status' => 200, 'data' => $rows];
    }

    // Update a record
    public function update($id, $data, $column) {
        if (!preg_match('/^[a-zA-Z_]+$/', $column)) {
            return ['status' => 400, 'message' => 'Invalid column name'];
        }
        $fields = [];
        foreach ($data as $field => $value) {
            $fields[] = "$field = :$field";
        }
        $fieldList = implode(", ", $fields);

        $query = "UPDATE " . $this->table_name . " SET $fieldList WHERE $column = :id";
        $stmt = $this->conn->prepare($query);

        foreach ($data as $field => $value) {
            $stmt->bindValue(":$field", $value);
        }
        $stmt->bindParam(":id", $id);

        if ($stmt->execute()) {
            return ['status' => 200, 'message' => 'Record updated successfully'];
        } else {
            return ['status' => 500, 'message' => 'Error updating record'];
        }
    }

    // Delete a record
    public function delete($id) {
        $query = "DELETE FROM " . $this->table_name . " WHERE id = :id";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(":id", $id);

        if ($stmt->execute()) {
            return ['status' => 200, 'message' => 'Record deleted successfully'];
        } else {
            return ['status' => 500, 'message' => 'Error deleting record'];
        }
    }
}
?>
