<?php
class Database {
    private $servername = 'localhost';
    private $user = 'root';
    private $pass = '';
    private $db = 'greekmyth';

    protected function connect() : mysqli {
        $conn = new mysqli($this->servername, $this->user, $this->pass);
        $conn->select_db($this->db);
        return $this->checkConnection($conn);
    }

    private function checkConnection($conn) : mysqli {
        if($conn->connect_error) {
            die("Connection failed: " . $conn->connect_error);
        }
        return $conn;
    }
}