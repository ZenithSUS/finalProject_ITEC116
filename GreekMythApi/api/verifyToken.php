<?php
require_once('apiStatus.php');
require_once('../queries/login.php');
class Token extends Login {
    public function __construct(){
        $this->conn = $this->connect();
    }

    public function tokenExists($token) : bool {
        $sql = "SELECT token FROM Admin_Users WHERE token = ?";
        $stmt = $this->conn->prepare($sql);
    
        if(!$stmt){
            return false;
        } else {
            $stmt->bind_param('s', $token);
            $stmt->execute();
            $result = $stmt->get_result();
            $status = $result->num_rows > 0 ? true : false;
            return $status;
        }
    }

    public function tokenVerified($token) : bool {
        $sql = "SELECT verified FROM Admin_Users WHERE token = ?";
        $stmt = $this->conn->prepare($sql);

        if(!$stmt) {
            return false;
        } else {
            $stmt->bind_param('s', $token);
            $stmt->execute();
            $result = $stmt->get_result();

            if($result->num_rows > 0){
                $row = $result->fetch_assoc();
                $status = $row['verified'] == 1 ? true : false;
                return $status;
            } else {
                return false;
            }
        }
    }
                
}

$TokenAuth = new Token();
?>