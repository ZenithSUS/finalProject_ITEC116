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
    if($requestMethod == "POST" && !isset($_GET['id']) && !isset($_POST['type'])){
        $limit = isset($_GET['limit']) && $_GET['limit'] !== null ? 10 : 0;
        $page = isset($_GET['page']) ? $_GET['page'] : 1; 
        $offset = ($page - 1) * $limit;
        echo $groups->getAllGroups($limit, $offset);
    }

    if($requestMethod == "POST" && isset($_GET['id']) && (isset($_POST['type']) && $_POST['type'] === "enable" || $_POST['type'] === "disable")){
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

    if($requestMethod == "POST" && !isset($_GET['id']) && isset($_POST['type'])){
        $creator = isset($_POST['creator']) ? strval(htmlentities($_POST['creator'])) : "";
        $name = isset($_POST['name']) ? htmlentities(($_POST['name'])) : "";
        $description = isset($_POST['description']) ? htmlentities($_POST['description']) : "";
        $image = isset($_FILES['image']) ? $_FILES['image'] : null;
        $type = $_POST['type'] ?? null;
        
        if(isset($type)){
            if($type === "createGroup") {
                echo $groups->createGroup($creator, $name, $description, $image);
            } 
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
        $id = isset($_GET['id']) ? strval(htmlentities($_GET['id'])) : "";
        $type = isset($_GET['type']) ? htmlentities($_GET['type']) : null;
        if (isset($id) && isset($type)){
            if($type === "getGroup"){
                echo $groups->getGroup($id);
            }
            if($type === "getGroups") {
                echo $groups->getUserGroups($id);
            }

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