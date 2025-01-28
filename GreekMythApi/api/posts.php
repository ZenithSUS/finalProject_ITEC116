<?php
include_once('headers.php');
require_once('../queries/posts.php');
require_once('verifyToken.php');

if (function_exists('getallheaders')) {
    $headers = getallheaders();
} elseif (function_exists('apache_request_headers')) {
    $headers = apache_request_headers();
} else {
    $headers = [];
    if (isset($_SERVER['HTTP_AUTHORIZATION'])) {
        $headers['Authorization'] = $_SERVER['HTTP_AUTHORIZATION'];
    } elseif (isset($_SERVER['REDIRECT_HTTP_AUTHORIZATION'])) {
        $headers['Authorization'] = $_SERVER['REDIRECT_HTTP_AUTHORIZATION'];
    } elseif (isset($_SERVER['Authorization'])) {
        $headers['Authorization'] = $_SERVER['Authorization'];
    } elseif (isset($_SERVER['HTTP_X_AUTHORIZATION'])) {
        $headers['Authorization'] = $_SERVER['HTTP_X_AUTHORIZATION']; 
    }
}
$posts = new Posts();

$token = $headers['Authorization'] ?? null;
if(isset($headers['Authorization'])){
    $token = explode(" ", $token);
    $token = $token[1];
} 

$requestMethod = $_SERVER['REQUEST_METHOD'];
if($requestMethod == "OPTIONS"){
    header("HTTP/1.1 200 OK");
    exit();
}

if($TokenAuth->tokenExists($token) && $TokenAuth->tokenVerified($token)){
    if($requestMethod == "POST" && !isset($_GET['id'])){
        $limit = isset($_GET['limit']) && $_GET['limit'] !== null ? 10 : 0;
        $page = isset($_GET['page']) ? $_GET['page'] : 1; 
        $offset = ($page - 1) * $limit;
        echo $posts->getAllPosts($limit, $offset);
    }
    
    if($requestMethod == "POST" && isset($_GET['id'])){
        $type = isset($_POST['type']) ? htmlentities($_POST['type']) : null;
        $id = isset($_GET['id']) ? htmlentities($_GET['id']) : null;
        if(isset($id) && isset($type)){
            echo $posts->changePermissionPost($id, $type);
        } else {
            $response = array(
                "status" => 400,
                "message" => "Bad request"
            );
            header("HTTP/1.1 400 Bad Request");
            echo json_encode($response);
        }
    }

    if($requestMethod == "GET"){
        if(isset($_GET['id'])){
            echo $posts->getPosts($_GET['id']);
        } else {
            $response = array(
                "status" => 400,
                "message" => "Bad request"
            );
            header("HTTP/1.1 400 Bad Request");
            echo json_encode($response);
        }
    }

    if($requestMethod == "DELETE"){
        $id = isset($_GET['id']) ? htmlentities($_GET['id']) : null;
        $type = isset($_GET['type']) ? htmlentities($_GET['type']) : null;

        if((isset($id) && $id !== null) && $type === "delete"){
            echo $posts->deletePost($id);
        } else {
            $response = array(
                "status" => 400,
                "message" => "Bad request"
            );
            header("HTTP/1.1 400 Bad Request");
            echo json_encode($response);
        }
    }
    
} else {
    if($token == null){
        $response = array(
            "status" => 401,
            "message" => "Unauthorized"
        );
        header("HTTP/1.1 401 Unauthorized");
        echo json_encode($response);
    } else {
        $response = array(
            "status" => 401,
            "message" => "Token not Verified"
        );
        header("HTTP/1.1 401 Unauthorized");
        echo json_encode($response);
    }
}


?>