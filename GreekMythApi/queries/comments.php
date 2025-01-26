<?php
require_once('../api/apiStatus.php');
class Comments extends Api {

    public function __construct(){
        $this->conn = $this->connect();
    }

    public function getAllComments(int $limit = 0, int $offset = 0) : string {
        $sql = $this->BuildCommentsQuery(null, $limit, $offset);
        $stmt = $this->conn->prepare($sql);

        if(!$stmt){
            return $this->queryFailed();
        } 

        $stmt->execute();
        $result = $stmt->get_result();
        $totalPages = $this->getTotalPageComment($limit);
        $status = $result->num_rows > 0 ? $this->Fetched($result, "comments", $totalPages) : $this->notFound();
        return $status;
    }

    public function getComment(string $id) : string {
        $sql = $this->BuildCommentsQuery($id);
        $stmt = $this->conn->prepare($sql);

        if(!$stmt){
            return $this->queryFailed();
        }

        $stmt->bind_param('s', $id);
        $stmt->execute();
        $result = $stmt->get_result();
        if($result->num_rows > 0){
            return $this->Fetched($result);
        } 
        return $this->notFound();   
    }

    public function changePermissionComment(string $id, string $type) : string {
        $sql = $this->changePermissionCommentQuery($type);
        $stmt = $this->conn->prepare($sql);

        if(!$stmt){
            return $this->queryFailed();
        }

        $stmt->bind_param('s', $id);
        return $stmt->execute() ? $this->editedResource() : $this->notFound();
    }

    public function deleteComment(string $id) : string {
        $sql = $this->deleteCommentQuery();
        $stmt = $this->conn->prepare($sql);

        if(!$stmt) {
            return $this->queryFailed();
        }

        $stmt->bind_param('s', $id);
        return $stmt->execute() ? $this->deletedResource() : $this->notFound();
    }

    private function BuildCommentsQuery($id = null, int $limit = 0, int $offset = 0) : string {
        if(isset($id) && $id != null){
            return "SELECT comments.comment_id, posts.title, 
            users.username, comments.content, comments.created_at, 
            comments.likes, comments.dislikes, comments.status, posts.created_at, greeks.name
            FROM Comments JOIN Users ON
            comments.author = users.user_id
            JOIN Posts ON
            comments.post_id = posts.post_id
            LEFT JOIN Greeks ON
            greeks.greek_id = posts.greek_group
            WHERE comments.comment_id = ?";
        }

        if(isset($limit) && $limit > 0){
            return "SELECT comments.comment_id, posts.title, users.username, 
            comments.content, comments.created_at, comments.likes, 
            comments.dislikes, comments.status, greeks.name
            FROM Comments JOIN Users ON
            comments.author = users.user_id
            JOIN Posts ON
            comments.post_id = posts.post_id
            LEFT JOIN Greeks ON
            greeks.greek_id = posts.greek_group
            LIMIT $limit OFFSET $offset";
        }

        return "SELECT comments.comment_id, posts.title, users.username, 
        comments.content, comments.created_at, comments.likes, 
        comments.dislikes, comments.status, greeks.name
        FROM Comments JOIN Users ON
        comments.author = users.user_id
        JOIN Posts ON
        comments.post_id = posts.post_id
        LEFT JOIN Greeks ON
        greeks.greek_id = posts.greek_group";
        
    }

    private function getTotalPageComment(int $limit) : int {
        $sql = "SELECT COUNT(*) FROM comments";
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

    private function changePermissionCommentQuery(string $type) : string {
        $status = $type == "enable" ? 1 : 0;
        return "UPDATE comments SET status = $status WHERE comment_id = ?";
    }

    private function deleteCommentQuery() : string {
        return "DELETE FROM comments WHERE comment_id = ?";
    }

}

?>