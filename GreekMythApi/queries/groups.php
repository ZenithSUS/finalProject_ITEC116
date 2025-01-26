<?php
require_once('../api/apiStatus.php');
class Groups extends Api {
    public function __construct(){
        $this->conn = $this->connect();
    }

    public function getAllGroups(int $limit = 0, int $offset = 0) : string {
        $sql = $this->BuildGroupsQuery(null, $limit, $offset);
        $stmt = $this->conn->prepare($sql);

        if(!$stmt){
            return $this->queryFailed();
        } 

        $stmt->execute();
        $result = $stmt->get_result();
        $totalPages = $this->getTotalPageGroup($limit);
        $status = $result->num_rows > 0 ? $this->Fetched($result, "groups", $totalPages) : $this->notFound();
        return $status;
    }

    public function getGroup(string $id) : string {
        $sql = $this->BuildGroupsQuery($id);
        $stmt = $this->conn->prepare($sql);

        if(!$stmt){
            return $this->queryFailed();
        } 
        $stmt->bind_param('s', $id);
        $stmt->execute();
        $result = $stmt->get_result();
        if($result->num_rows > 0){
            return $this->Fetched($result, "groups");
        } 
        return $this->notFound();     
    }

    private function BuildGroupsQuery(string $id = null, int $limit = 0, int $offset = 0) : string {
        if(isset($id) && $id !== null) {
            return "SELECT greeks.*, 
            CASE 
                WHEN greeks.creator = 'Default'
                THEN users.username = NULL
                ELSE users.username 
            END AS username, 
            COUNT(users.user_id) AS total_people FROM greeks
            LEFT JOIN user_groups ON greeks.greek_id = user_groups.greek_id
            LEFT JOIN users ON user_groups.user_id = users.user_id
            WHERE greeks.greek_id = ?
            GROUP BY greeks.greek_id";
        }

        if(isset($limit) && $limit > 0){
            return "SELECT greeks.*, 
            CASE 
                WHEN greeks.creator = 'Default'
                THEN users.username = NULL
                ELSE users.username 
            END AS username, 
            COUNT(users.user_id) AS total_people FROM greeks
            LEFT JOIN user_groups ON greeks.greek_id = user_groups.greek_id
            LEFT JOIN users ON user_groups.user_id = users.user_id
            GROUP BY greeks.greek_id
            LIMIT $limit OFFSET $offset";
        }

        return "SELECT greeks.*, 
            CASE 
                WHEN greeks.creator = 'Default'
                THEN users.username = NULL
                ELSE users.username 
            END AS username, 
            COUNT(users.user_id) AS total_people FROM greeks
            LEFT JOIN user_groups ON greeks.greek_id = user_groups.greek_id
            LEFT JOIN users ON user_groups.user_id = users.user_id
            GROUP BY greeks.greek_id";
    }


    
    public function changePermissionGroup(string $id, string $type) : string {
        $status = $type == "enable" ? 1 : 0;
        $sql = "UPDATE greeks SET status = $status WHERE greek_id = ?";
        $stmt = $this->conn->prepare($sql);

        if(!$stmt){
            return $this->queryFailed();
        } 
        $stmt->bind_param('s', $id);
        return $stmt->execute() ? $this->editedResource() : $this->notFound();
    } 

    public function deleteGroup(string $id) : string {
        $imageUrl = $this->getGroupImageUrl($id);
        if ($this->deleteGroupById($id)) {
            if (!empty($imageUrl)) {
                unlink($this->imagePath['gods'] . $imageUrl);
            }
            return $this->deletedResource();
        } else {
            return $this->notFound();
        }
    }

    private function getTotalPageGroup(int $limit) : int {
        $sql = "SELECT COUNT(*) FROM greeks";
        $stmt = $this->conn->prepare($sql);

        if(!$stmt) {
            return 0;
        }

        if($limit > 0 && $stmt->execute()) {
            $result = $stmt->get_result();
            $totalRecords = $result->fetch_assoc()['COUNT(*)'];
            $totalPages = ceil($totalRecords / $limit);
            return $totalPages;
        }

        return 0;
    }

    private function deleteGroupById(string $id): bool {
        $sql = "DELETE FROM greeks WHERE greek_id = ?";
        $stmt = $this->conn->prepare($sql);
        if (!$stmt) {
            return false;
        }
        $stmt->bind_param('s', $id);
        return $stmt->execute();
    }

    private function getGroupImageUrl(string $id): ?string {
        $sql = "SELECT image_url FROM greeks WHERE greek_id = ?";
        $stmt = $this->conn->prepare($sql);
        if (!$stmt) {
            return null;
        }
        $stmt->bind_param('s', $id);
        if ($stmt->execute()) {
            $result = $stmt->get_result();
            $row = $result->fetch_assoc();
            return $row['image_url'] ?? null;
        }
        return null;
    }
}
?>