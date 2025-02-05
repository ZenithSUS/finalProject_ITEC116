<?php
include_once('headers.php');
require_once('../queries/users.php');
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
$requestMethod = $_SERVER["REQUEST_METHOD"];

$users = new Users();

$token = $headers['Authorization'] ?? null;
if(isset($headers['Authorization'])){
    $token = explode(" ", $token);
    $token = $token[1];
} 

if($requestMethod == "OPTIONS") {
    header("HTTP/1.1 200 OK");
    exit();
}

if($TokenAuth->tokenExists($token) && $TokenAuth->tokenVerified($token)){

    if($requestMethod == "POST" && !isset($_GET['id']) && !isset($_POST['type'])){
        $limit = isset($_GET['limit']) && $_GET['limit'] !== null ? 10 : 0;
        $page = isset($_GET['page']) ? $_GET['page'] : 1; 
        $offset = ($page - 1) * $limit;
        echo $users->getAllUsers($limit, $offset);
    }

    if($requestMethod == "POST" && isset($_GET['id']) && isset($_POST['type'])){
        $id = isset($_GET['id']) ? htmlentities($_GET['id']) : null;
        $type = htmlentities(isset($_POST['type'])) ? htmlentities($_POST['type']) : null;
    
        if(isset($id) && $id !== null && ($type === "user" || $type === "admin")){
            $username = strlen(htmlentities($_POST['usernameEdit'])) > 0 ? htmlentities($_POST['usernameEdit']) : null;
            $email = strlen(htmlentities($_POST['emailEdit'])) > 0 ? htmlentities($_POST['emailEdit']) : null;
            $image = isset($_FILES['image']) ? $_FILES['image'] : null;
            echo $users->editUser($id, $username, $email, $type, $image); 
        }

        if(isset($id) && $id !== null && $type === "adminPass"){
            $newPassword = strlen(htmlentities($_POST['newpassword'])) > 0 ? htmlentities($_POST['newpassword']) : null;
            $confirmNewPassword = strlen(htmlentities($_POST['newconfirmpassword'])) > 0 ? htmlentities($_POST['newconfirmpassword']) : null;
            echo $users->changeAdminPassword($id, $newPassword, $confirmNewPassword);
        }

        if(isset($id) && $id !== null && $type === "deleteAdmin"){
            $password = strlen(htmlentities($_POST['password'])) > 0 ? htmlentities($_POST['password']) : null;
            $confirmPassword = strlen(htmlentities($_POST['confirmpassword'])) > 0 ? htmlentities($_POST['confirmpassword']) : null;
            echo $users->check_Delete_Account_PasswordFields($id, $password, $confirmPassword);
        }

        if(isset($id) && $id !== null && ($type === "light" || $type === "dark")){
            $fontstyle = htmlentities(isset($_POST['font_style'])) ? htmlentities($_POST['font_style']) : null;
            echo $users->changeThemeAdmin($id, $type, $fontstyle); 
        }

        if(!isset($id) && !isset($type)){
            $response = array(
                "status" => 400,
                "message" => "Bad request"
            );
            header("HTTP/1.1 400 Bad Request");
            echo json_encode($response);
        } else if(!isset($type)){
            $response = array(
                "status" => 400,
                "message" => "Bad request"
            );
            header("HTTP/1.1 400 Bad Request");
            echo json_encode($response);
        }
    }

    if($requestMethod == "POST" && !isset($_GET['id']) && isset($_POST['type'])){
        $type = htmlentities(isset($_POST['type'])) ? htmlentities($_POST['type']) : null;
        
        if(!isset($id) && $type === "createUser"){
        
            $username = strlen(htmlentities($_POST['username'])) > 0 ? htmlentities($_POST['username']) : null;
            $email = strlen(htmlentities($_POST['email'])) > 0 ? htmlentities($_POST['email']) : null;
            $password = strlen(htmlentities($_POST['password'])) > 0 ? htmlentities($_POST['password']) : null;
            $confirmPassword = strlen(htmlentities($_POST['confirm_password'])) > 0 ? htmlentities($_POST['confirm_password']) : null;
            $image = isset($_FILES['image']) ? $_FILES['image'] : null;
            $bio = strlen(htmlentities($_POST['bio'])) > 0 ? htmlentities($_POST['bio']) : null;
            echo $users->createUser($username, $email, $password, $confirmPassword, $image, $bio, $type);
        }
        
    }

    if($requestMethod == "GET") {
        if(isset($_GET['id'])){
            echo $users->getUser($_GET['id']);
        } else if (isset($_GET['user_id'])){
            echo $users->getAdminInfo($_GET['user_id']);
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

        if((isset($id) && $id !== null) && $type === "user"){
            echo $users->deleteUser($id);
        }
        
        if((isset($id) && $id !== null) && $type === "admin"){
            echo $users->deleteAdminUser($id);
        }

        if(!isset($id) && !isset($type)){
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
            "message" => "Token not Verified",
            "data" => $token
        );
        header("HTTP/1.1 401 Unauthorized");
        echo json_encode($response);
    }
}
?>