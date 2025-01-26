<?php
include_once('headers.php');
require_once('../queries/comments.php');
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

$commments = new Comments();

$requestMethod = $_SERVER['REQUEST_METHOD'];
$token = $headers['Authorization'] ?? null;

if(isset($token)){
    $token = explode(" ", $token);
    $token = $token[1];
}

if($requestMethod == "OPTIONS"){
    header("HTTP/1.1 200 OK");
    exit;
}

if($TokenAuth->tokenExists($token) && $TokenAuth->tokenVerified($token)){
    if($requestMethod == "POST"  && !isset($_GET['id'])){
        $limit = isset($_GET['limit']) && $_GET['limit'] !== null ? 10 : 0;
        $page = isset($_GET['page']) ? $_GET['page'] : 1; 
        $offset = ($page - 1) * $limit;
        echo $commments->getAllComments($limit, $offset);
    }

    if($requestMethod == "POST"  && isset($_GET['id']) && isset($_POST['type'])){
        $id = htmlentities($_GET['id']) ?? null;
        $type = htmlentities($_POST['type']) ?? null;
        if(isset($id) && isset($type)){
            echo $commments->changePermissionComment($id, $type);
        }
    }

    if($requestMethod == "GET"){
        $id = htmlentities($_GET['id']) ?? null;
        if(isset($id)){
            echo $commments->getComment($id);
        }
    }

    if($requestMethod == "DELETE") {
        $id = htmlentities($_GET['id']) ?? null;
        $type = htmlentities($_GET['type']) ?? null;

        if((isset($id) && $id !== null) && $type === "delete"){
            echo $commments->deleteComment($id);
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
            "message" => "Token not verified"
        );
        header("HTTP/1.1 401 Unauthorized");
        echo json_encode($response);
    }
}
?>