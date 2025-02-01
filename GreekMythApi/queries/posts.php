<?php
require_once('../api/apiStatus.php');

class Posts extends Api {

    public function __construct(){
        $this->conn = $this->connect();
    }
    
    public function getAllPosts(int $limit = 0, int $offset = 0) : string {
        $sql = $this->BuildPostQuery(null, $limit, $offset);
        $stmt = $this->conn->prepare($sql);

        if(!$stmt){
           return $this->queryFailed();
        } else {
            $stmt->execute();
            $result = $stmt->get_result();
            $totalPages = $this->getTotalPagePost($limit);
            $status = $result->num_rows > 0 ? $this->Fetched($result, "posts", $totalPages) : $this->notFound();
            return $status;
        }
    }

    public function getPosts(string $id) : string {
        $sql = $this->BuildPostQuery($id);
        $stmt = $this->conn->prepare($sql);

        if(!$stmt){
            return $this->queryFailed();
        } else {
            $stmt->bind_param('s', $id);
            $stmt->execute();
            $result = $stmt->get_result();

            $status = $result->num_rows > 0 ? $this->Fetched($result, "posts") : $this->notFound();
            return $status;
        }
    }

    public function deletePost(string $id) : string {
        $sql = "DELETE FROM posts WHERE post_id = ?";
        $stmt = $this->conn->prepare($sql);

        if(!$stmt){
            return $this->queryFailed("Delete");
        } else {
            $stmt->bind_param('s', $id);
            $stmt->execute();

            if($stmt->execute()){
                return $this->deletedResource();
            } else {
                return $this->notFound();
            }
        }
    }

    public function changePermissionPost(string $id, string $type) : string {
        $switch = $type === "enable" ? 1 : 0;
        $sql = "UPDATE posts SET status = $switch WHERE post_id = ?";
        $stmt = $this->conn->prepare($sql);

        if(!$stmt){
            return $this->queryFailed();
        } else {
            $stmt->bind_param('s', $id);
            return $stmt->execute() ? $this->editedResource() : $this->notFound();
        }
    }

    private function BuildPostQuery(string $id = null, int $limit = 0, int $offset = 0) : string {
        if(isset($id) && $id !== null){
            return "SELECT posts.post_id, posts.author, users.username, posts.title, posts.content, posts.created_at, posts.likes, posts.dislikes, posts.status, greeks.name 
            FROM Posts JOIN Users ON users.user_id = posts.author
            LEFT JOIN Greeks ON posts.greek_group = greeks.greek_id
            WHERE posts.post_id = ?";
        }

        if(isset($limit) && $limit > 0) {
            return "SELECT posts.post_id, users.username, posts.title, posts.content, posts.created_at, posts.likes, posts.dislikes, posts.status, greeks.name
            FROM Users JOIN Posts ON users.user_id = posts.author
            LEFT JOIN Greeks ON posts.greek_group = greeks.greek_id
            ORDER BY posts.created_at DESC
            LIMIT $limit OFFSET $offset";
        }

        return "SELECT posts.post_id, users.username, posts.title, posts.content, posts.created_at, posts.likes, posts.dislikes, posts.status, greeks.name
        FROM Users JOIN Posts ON users.user_id = posts.author
        LEFT JOIN Greeks ON posts.greek_group = greeks.greek_id
        ORDER BY posts.created_at DESC";
    }

    private function getTotalPagePost(int $limit) : int {
        $sql = "SELECT COUNT(*) FROM posts";
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


    public function createPost(?string $userId = null, ?string $greekId, ?string $title = null, ?string $content) : string {
        $sql = "INSERT INTO posts (post_id, author, greek_group, title, content) VALUES (UUID(), ?, ?, ?, ?)";
        $stmt = $this->conn->prepare($sql);
        
        if(empty($title) || $title === null || $title === "") {
            $this->errors['titleCreate'] = "Please enter a title";
        }

        if(empty($content) || $content === null || $content === "") {
            $this->errors['contentCreate'] = "Please enter content";
        }

        if(empty($userId) || $userId === null || $userId === "") {
            $this->errors['usernameCreate'] = "Please select a user";
        }

        if(empty($greekId) || $greekId === null || $greekId === "") {
            $greekId = null;
        } 

        if(!empty($this->errors)) {
            return $this->queryFailed("Create", $this->errors);
        }

        if(isset($userId) && $userId !== null) {
            $stmt->bind_param('ssss', $userId, $greekId, $title, $content);
        }

        if(!$stmt) {
            return $this->queryFailed();
        }

        $stmt->execute();
        if($stmt->affected_rows > 0)  {
            $postId = $this->getPostById($userId, $title);
            $greekName = $this->getGreekName($greekId);
            if($greekName !== null) {
                $this->addActivityPost($userId, "created a post with title " . $title . " in " . $greekName . " discussion", $postId);
            } else {
                $this->addActivityPost($userId, "created a post with title " . $title, $postId);
            }
            return $this->created();
        } else {
            return $this->queryFailed();
        }
    }


    private function addActivityPost(?string $userId = null, ?string $activity = null, ?string $postId = null) : void {
        $sql = "INSERT INTO activities (user_id, activity, post_id) VALUES (?, ?, ?)";
        $stmt = $this->conn->prepare($sql);
        $stmt->bind_param('sss', $userId, $activity, $postId);
        $stmt->execute();
    }

    private function getPostById(?string $userId = null, ?string $title) : string {
        $sql = "SELECT post_id FROM posts WHERE author = ? AND title = ?";
        $stmt = $this->conn->prepare($sql);

        if(!$stmt){
            return null;
        } else {
            $stmt->bind_param('ss', $userId, $title);
            $stmt->execute();
            $result = $stmt->get_result();
            $row = $result->fetch_assoc();
            $postId = $row['post_id'] ?? null;
            return $postId != null ? $postId : null;
        }
    }

    private function getGreekName(?string $greekId) : string {
        $sql = "SELECT name FROM Greeks WHERE greek_id = ?";
        $stmt = $this->conn->prepare($sql);
        $stmt->bind_param('s', $greekId);
        $stmt->execute();
        $result = $stmt->get_result();
        $row = $result->fetch_assoc();
        return $row['name'] ?? null;
    }
}
?>