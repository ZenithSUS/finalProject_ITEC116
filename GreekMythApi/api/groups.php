<?php
include_once('headers.php');
require_once('../queries/groups.php');
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

$groups = new Groups();

$requestMethod = $_SERVER['REQUEST_METHOD'];
$token = $headers['Authorization'] ?? null;
if(isset($headers['Authorization'])){
    $token = explode(" ", $token);
    $token = $token[1];
}

if($requestMethod == "OPTIONS"){
    header("HTTP/1.1 200 OK");
    exit();
}

if($TokenAuth->tokenVerified($token) && $TokenAuth->tokenExists($token)){
    if($requestMethod == "POST" && !isset($_GET['id'])){
        $limit = isset($_GET['limit']) && $_GET['limit'] !== null ? 10 : 0;
        $page = isset($_GET['page']) ? $_GET['page'] : 1; 
        $offset = ($page - 1) * $limit;
        echo $groups->getAllGroups($limit, $offset);
    }

    if($requestMethod == "POST" && isset($_GET['id'])){
        $id = isset($_GET['id']) ? htmlentities($_GET['id']) : null;
        $type = $_POST['type'] ?? null;
        if(isset($id) && isset($type)){
            echo $groups->changePermissionGroup($id, $type);
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
        $id = isset($_GET['id']) ? htmlentities($_GET['id']) : "";
        if(isset($id)){
            echo $groups->getGroup($id);
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
            echo $groups->deleteGroup($id);
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
            "message" => "Token not verified"
        );
        header("HTTP/1.1 401 Unauthorized");
        echo json_encode($response);
    }
    
}
?>