<?php
require_once('../api/apiStatus.php');
class Groups extends Api {
    protected $errors = array();

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

    public function getUserGroups(string $id) : string {
        $sql = "SELECT user_groups.greek_id, greeks.name 
        FROM user_groups 
        JOIN greeks ON user_groups.greek_id = greeks.greek_id
        WHERE user_id = ?";
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

    // Function to create a new group
    public function createGroup(?string $creator = null, ?string $name = null, ?string $description, $image = null) : string {
        $creator = isset($creator) ? strval(htmlentities($creator)) : "";
        $sql = $this->createGroupQuery();
        $stmt = $this->conn->prepare($sql);
        
        if(!$stmt) {
            return $this->queryFailed();
        }
        
        if(empty($creator) || $creator === null || $creator === "") {
            $this->errors['creatorCreate'] = "Please select a creator";
        }

        if(empty($name) || $name === null || $name === "") {
            $this->errors['nameCreate'] = "Please enter a name";
        }

        if(empty($description) || $description === null || $description === "") {
            $this->errors['descriptionCreate'] = "Please enter a description";
        }

        if(!empty($this->errors)){
            return $this->queryFailed('Create', $this->errors);
        }

        if(empty($this->errors)) {
            $image_url = $this->createImage($image);
        }

        if(isset($creator) && $creator !== null && isset($name) && $name !== null && isset($description) && $description !== null) {
            $stmt->bind_param('ssss', $name, $description, $image_url, $creator);
        }

        if(!$stmt->execute()) {
            return $this->queryFailed();
        }

        // Get the ID of the newly created group
        $sql = "SELECT greek_id FROM greeks WHERE name = ?";
        $stmt = $this->conn->prepare($sql);
        $stmt->bind_param('s', $name);
        $stmt->execute();
        $result = $stmt->get_result();
        $row = $result->fetch_assoc();
        $name = $row['greek_id'];

        // Insert the user group into the database
        $sql = "INSERT INTO user_groups (id, user_id, greek_id) VALUES (UUID(), ?, ?)";
        $stmt = $this->conn->prepare($sql);
        $stmt->bind_param('ss', $creator, $name);
        
        return $stmt->execute() ? $this->created() : $this->queryFailed();
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

    private function createGroupQuery() : string {
        return "INSERT INTO greeks (greek_id, name, description, image_url, creator) VALUES (UUID(), ?, ?, ?, ?)";
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

        // Function to create greek or group image
        private function createImage($image = null) : ?string {
            if($image === null) {
                return null;
            }

            $fileName = $image['name'] ?? null;
            $fileSize = $image['size'] ?? null;
            $fileTmpName = $image['tmp_name'] ?? null;
            $fileError = $image['error'] ?? null;
            $fileExt = explode('.', $fileName);
            $fileActualExt = strtolower(end($fileExt));
            $fileNameNew = uniqid('', true) . "." . $fileActualExt;
            $targetDirectory = $this->imageConfig['gods'] . $fileNameNew; 
            
            $allowed = array("jpeg", "png", "jpg");
        
            if ($fileError !== UPLOAD_ERR_OK) {
                $this->errors['imageCreate'] = 'Error Uploading Image!';
            }
        
            if (!in_array($fileActualExt, $allowed)) {
                $this->errors['imageCreate'] = 'Invalid Extension!';
            } 
        
            if ($fileSize > 5000000) {
                $this->errors['imageCreate'] = 'Image size too big!';
            }
    
            if(!empty($this->errors)){
                return null;
            }
    
            if(!move_uploaded_file($fileTmpName, $targetDirectory)) {
                $this->errors['imageCreate'] = 'Failed to upload image';
                return null;
            }
    
            return $image_url = $fileNameNew;
        }
}
?>