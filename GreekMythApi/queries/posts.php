<?php
require_once('../api/apiStatus.php');

class Posts extends Api {

    protected $errors = array();

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
            $this->errors['groupCreate'] = "Please select a greek group";
        }

        if(!empty($this->errors)) {
            return $this->queryFailed("Create", $this->errors);
        }

        if(isset($userId) && $userId !== null && isset($greekId) && $greekId !== null) {
            $stmt->bind_param('ssss', $userId, $greekId, $title, $content);
        }

        if(!$stmt) {
            return $this->queryFailed();
        }

        $stmt->execute();
        return $stmt->affected_rows > 0 ? $this->created() : $this->queryFailed();
    }

}
?>