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
        $type = htmlentities($_POST['type']) ?? null;
        $id = htmlentities($_GET['id']) ?? null;
        if(isset($id) && isset($type)){
            echo $posts->changePermissionPost($id, $type);
        }
    }

    if($requestMethod == "GET"){
        if(isset($_GET['id'])){
            echo $posts->getPosts($_GET['id']);
        }
    }

    if($requestMethod == "DELETE"){
        $id = htmlentities($_GET['id']) ?? null;
        $type = htmlentities($_GET['type']) ?? null;

        if((isset($id) && $id !== null) && $type === "delete"){
            echo $posts->deletePost($id);
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