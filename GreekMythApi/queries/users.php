<?php
require_once('../api/apiStatus.php');
class Users extends Api {

    // Constructor to initialize database connection
    public function __construct(){
        $this->conn = $this->connect();
    }

    // Function to get admin information by ID
    public function getAdminInfo(string $id) : string {
        $sql = "SELECT admin_users.username, admin_users.image_src, admin_users.email, admin_settings.dark_mode
        FROM Admin_Users 
        JOIN Admin_Settings ON
        admin_users.id = admin_settings.admin_id
        WHERE admin_users.id = ?";
        $stmt = $this->conn->prepare($sql);

        if(!$stmt) {
            return $this->queryFailed();
        } else {
            $stmt->bind_param('s', $id);
            $stmt->execute();
            $result = $stmt->get_result();
            if($result->num_rows > 0){
                return $this->Fetched($result, "admins");
            } else {
                return $this->notFound();
            }
            $stmt->close();
        }
    }

    // Function to change admin password
    public function changeAdminPassword(string $id, ?string $newPassword = null, ?string $confirmNewPassword = null) : string {
        $this->checkPasswordFields($id, $newPassword, $confirmNewPassword);
        if(!empty($this->errors)){
            return $this->queryFailed("Edit", $this->errors);
        }

        $sql = $this->changePasswordQuery();
        $stmt = $this->conn->prepare($sql);

        if(!$stmt) {
            return $this->queryFailed();
        }

        $newPassHash = password_hash($newPassword, PASSWORD_DEFAULT);
        $stmt->bind_param('ss', $newPassHash, $id);
        $stmt->execute();
        return $stmt->affected_rows > 0 ? $this->editedResource() : $this->queryFailed();
    }

    // Function to get all users with pagination
    public function getAllUsers(int $limit = 0, int $offset = 0) : string {
        $sql = $this->BuildUserQuery(null, $limit, $offset);
        $stmt = $this->conn->prepare($sql);
     
        if(!$stmt) {
            return $this->queryFailed();
        } else {
            $stmt->execute();
            $result = $stmt->get_result();
            $totalPages = $this->getTotalPageUser($limit);
            if($result->num_rows > 0){
                return $this->Fetched($result, "users", $totalPages);
            } else {
                return $this->notFound();
            }
            $stmt->close();
        }
    }

    // Function to get user by ID
    public function getUser(string $id) : string {
        $sql = $this->BuildUserQuery($id);
        $stmt = $this->conn->prepare($sql);

        if(!$stmt){
            return $this->queryFailed();
        } 

        $stmt->bind_param('s', $id);
        $stmt->execute();
        $result = $stmt->get_result();
            
        if($result->num_rows > 0){
            $stmt->close();
            return $this->Fetched($result, "users");
        } else {
            return $this->notFound();
        }
    }

    // Function to build user query based on parameters
    private function BuildUserQuery(string $id = null, int $limit = 0, int $offset = 0) : string {
        if(isset($id) && $id !== null) {
            return "SELECT users.username, users.email, users.bio, users.profile_pic, users.joined_at, 
            (SELECT COUNT(posts.author) FROM posts WHERE posts.author = users.user_id) AS totalPosts, 
            (SELECT COUNT(comments.author) FROM comments WHERE comments.author = users.user_id) AS totalComments,
            (SELECT COUNT(friends.user_id) FROM friends WHERE friends.user_id = users.user_id) AS totalFriends,
            (SELECT COUNT(user_groups.user_id) FROM user_groups WHERE user_groups.user_id = users.user_id) AS totalGroups
            FROM users 
            WHERE users.user_id = ?";
        }

        if(isset($limit) && $limit > 0){
            return "SELECT users.user_id, users.username, users.email, users.joined_at, 
            users.profile_pic, users.bio, COUNT(friends.user_id) AS totalFriends
            FROM users
            LEFT JOIN friends ON users.user_id = friends.user_id
            GROUP BY users.user_id
            LIMIT $limit OFFSET $offset";
        }

        return "SELECT users.user_id, users.username, users.email, users.joined_at, 
        users.profile_pic, users.bio, COUNT(friends.user_id) AS totalFriends
        FROM users
        LEFT JOIN friends ON users.user_id = friends.user_id
        GROUP BY users.user_id";
    }

    // Function to get total pages for users
    private function getTotalPageUser(int $limit) : int {
        $sql = "SELECT COUNT(*) FROM users";
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

    public function createUser(?string $username = null, ?string $email = null, ?string $password = null, ?string $confirmPassword = null, $image = null, ?string $bio = null, ?string $type = null) : string {
        $this->checkFieldsCreate($username, $email, $type);
        $this->checkPasswordFieldsCreate($password, $confirmPassword);

        // Check if username exists
        $sql = $this->getUsernameQuery2();
        $exists = $this->existsUsernameOrEmailInCreate($sql, $username);

        if($exists){
            $this->errors['usernameCreate'] = "Username already exists";
        }

        // Check if email exists
        $sql = $this->getEmailQuery2();
        $exists = $this->existsUsernameOrEmailInCreate($sql, $email);

        if($exists){
            $this->errors['emailCreate'] = "Email already exists";
        }

        if(!empty($this->errors)){
            return $this->queryFailed("Create", $this->errors);
        }
        $image_url = $this->createImage($image);   
        return $this->createUserQuery($username, $email, $password, $bio, $image_url);
    }

    private function createUserQuery(string $username, string $email, string $password, ?string $bio, ?string $image_url = null) : string {
        $sql = "INSERT INTO users (user_id, username, email, password, token, bio, profile_pic) VALUES (UUID(), ?, ?, ?, ?, ?, ?)";
        $stmt = $this->conn->prepare($sql);

        if(!$stmt){
            return $this->queryFailed();
        }
        
        $token = bin2hex(random_bytes(16));
        $password = password_hash($password, PASSWORD_DEFAULT);
        $stmt->bind_param("ssssss", $username, $email, $password, $token, $bio, $image_url);
        $stmt->execute();

        // Get user id
        $sql = "SELECT user_id FROM users WHERE email = ? OR username = ? LIMIT 1"; 
        $stmt = $this->conn->prepare($sql);

        if(!$stmt){
            return $this->queryFailed();
        }

        $stmt->bind_param("ss", $email, $username);
        $stmt->execute();

        $result = $stmt->get_result();
        $row = $result->fetch_assoc();
        // Get user id
        $user_id = $row['user_id'];

        $this->insertDefaultPages($user_id);
        return $stmt->affected_rows > 0 ? $this->created() : $this->queryFailed();
    }

    // Function to edit user information
    public function editUser(string $id, ?string $username = null, ?string $email = null, string $type, $image = null) : string {
        $this->checkFields($username, $email, $type);
        if(!empty($this->errors)){
            return $this->queryFailed("Edit", $this->errors);
        }

        // Check if username exists
        $sql = $this->getUsernameQuery($type);
        $Exists = $this->existsUsernameOrEmail($id, $sql, $username);
        
        if($Exists){
            $errors['usernameEdit'] = "Username already exists";
        }

        // Check if email exists
        $sql = $this->getEmailQuery($type);
        $Exists = $this->existsUsernameOrEmail($id, $sql, $email);
        
        if($Exists){
            $errors['emailEdit'] = "Email already exists";
        }

        if(!empty($errors)){
            return $this->queryFailed("Edit", $errors);
        }

        $sql = $this->editUserQuery($type);
        $stmt = $this->conn->prepare($sql);
 
        if(!$stmt){
            return $this->queryFailed();
        }
        
        $stmt->bind_param('sss', $username, $email, $id);
        $stmt->execute();
            
        if($stmt->affected_rows > 0 || $image !== null){
            if(!empty($image)){
                if($this->changeImage($id, $image) === false){
                    $stmt->close();
                    return $this->queryFailed("Edit", $this->errors);
                }
            }
            $stmt->close();
            return $this->editedResource();
        }

        if($stmt->affected_rows === 0 || $image === null){
            $stmt->close();
            return $this->editedResource();
        }
        
        if(!empty($this->errors)){
            $stmt->close();
            return $this->queryFailed("Edit", $this->errors);
        }

        $sql = $this->getUserInfoQuery($type);
        $stmt = $this->conn->prepare($sql);

        if(!$stmt) {
            return $this->queryFailed();
        } 
        $stmt->bind_param('s', $id);
        $stmt->execute();
        $result = $stmt->get_result();
        $row = $result->fetch_assoc();

        // Check if username and email fields are the same
        if($row['username'] === $username && $row['email'] === $email){
            $errors['status'] = "Please edit information";
        }

        if(!empty($errors)){
            $stmt->close();
            return $this->queryFailed("Edit", $errors);
        }

        return $this->notFound();
    }

    // Function to check delete account password fields
    public function check_Delete_Account_PasswordFields(string $id, ?string $password = null, ?string $confirmPassword = null) : string {
        $this->check_Admin_Delete_Password_Fields($password, $confirmPassword);
        if(!empty($this->errors)){
            return $this->queryFailed("DeleteAdmin", $this->errors);
        }

        if(!$this->verifyPassword($id, $password)){
            $this->errors['delstatus'] = "Wrong Password!";
        }

        if(!empty($this->errors)){
            return $this->queryFailed("DeleteAdmin", $this->errors);
        }

        return $this->success();
    }

    // Function to delete admin user
    public function deleteAdminUser(string $id) : string {
        $sql = "SELECT image_src FROM admin_users WHERE id = ?";
        $stmt = $this->conn->prepare($sql);
        $stmt->bind_param('s', $id);

        if(!$stmt) {
            return $this->queryFailed("Delete");
        }

        $stmt->execute();
        $result = $stmt->get_result();
        $row = $result->fetch_assoc();
        $image = $row['image_src'];

        if($result->num_rows > 0){
            if($image !== null){
                unlink($this->imageConfig['admins'] . $image);
            } 
            $stmt->close();
            return $this->deleteAdminUserQuery($id);
        } 
        return $this->notFound(); 
    }

    // Function to delete admin user query
    private function deleteAdminUserQuery(string $id) {
        $sql = "DELETE FROM admin_users WHERE id = ?";
        $stmt = $this->conn->prepare($sql);
        $stmt->bind_param('s', $id);

        $stmt->execute();
        return $stmt->affected_rows > 0 ? $this->deletedResource() : $this->notFound();
    }

    // Function to delete user
    public function deleteUser(string $id) : string {
        $sql = "SELECT profile_pic FROM users WHERE user_id = ?";
        $stmt = $this->conn->prepare($sql);

        if(!$stmt) {
            return $this->queryFailed("Delete");
        } 
        $stmt->bind_param('s', $id);
        $stmt->execute();
        $result = $stmt->get_result();
        $row = $result->fetch_assoc();
        $image = $row['profile_pic'];

        if($result->num_rows > 0){
            if($image !== null){
                unlink($this->imageConfig['users'] . $image);
            } 
            $stmt->close();
            return $this->deleteUserQuery($id);
        } 
        return $this->notFound();  
    }

    // Function to change admin theme
    public function changeThemeAdmin(string $id, ?string $type = null, ?string $fontstyle = null) : string {
        $sql = $this->changeThemeAdminQuery($type);
        $stmt = $this->conn->prepare($sql);
        $stmt->bind_param('ss', $fontstyle, $id);

        if(!$stmt){
            return $this->queryFailed();
        }

        $stmt->execute();
        return $stmt->affected_rows > 0 ? $this->editedResource() : $this->queryFailed();
    }

    // Function to insert default group pages on user creation in database
    private function insertDefaultPages($user_id) {
        $sql = "SELECT * FROM greeks WHERE creator = 'Default'";
        $result = $this->conn->query($sql);
    
        if($result !== false && $result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $sql = "INSERT INTO user_groups (id, user_id, greek_id) VALUES (UUID(), ?, ?)";
                $stmt = $this->conn->prepare($sql);
                $stmt->bind_param("ss", $user_id, $row['greek_id']);
                $stmt->execute();
                $stmt->close();
            }
        }
    }

    // Function to get user info query based on type
    private function getUserInfoQuery(string $type) : string {
        return $type === "user" ? "SELECT username, email FROM users WHERE user_id = ?" : "SELECT username, email FROM admin_users WHERE id = ?";
    }

    // Function to get username query based on type
    private function getUsernameQuery(string $type) : string {
        return $type === "user" ? "SELECT username FROM users WHERE user_id != ? AND username = ?" : "SELECT username FROM admin_users WHERE id != ? AND username = ?";
    }

    // Function to get username query in creating user
    private function getUsernameQuery2() : string {
        return "SELECT username FROM users WHERE username = ?";
    }

    // Function to get email query based on type
    private function getEmailQuery(string $type) : string {
        return $type === "user" ? "SELECT email FROM users WHERE user_id != ? AND email = ?" : "SELECT email FROM admin_users WHERE id != ? AND email = ?";
    }

    // Function to get email query in creating user
    private function getEmailQuery2() : string {
        return "SELECT email FROM users WHERE email = ?";
    }

    // Function to check if username or email exists in creating user
    private function existsUsernameOrEmailInCreate(?string $sql = null, ?string $user = null) : bool {
        $stmt = $this->conn->prepare($sql);

        if(!$stmt){
            return false;
        }

        $stmt->bind_param('s', $user);
        $stmt->execute();
        $result = $stmt->get_result();
        return $result->num_rows > 0 ? true : false;
    }

    // Function to check if username or email exists
    private function existsUsernameOrEmail(string $id, string $sql, string $username) : bool {
        $stmt = $this->conn->prepare($sql);

        if(!$stmt){
            return false;
        }

        $stmt->bind_param('ss', $id, $username);
        $stmt->execute();
        $result = $stmt->get_result();
        return $result->num_rows > 0 ? true : false;
    }

    // Function to edit user query based on type
    private function editUserQuery(string $type) : string {
        if($type === "user"){
            return "UPDATE users 
            SET username = ?, email = ?
            WHERE user_id = ?";
        }

        return "UPDATE admin_users
            SET username = ?, email = ?
            WHERE id = ?";
    }

    // Function to delete user query
    private function deleteUserQuery(string $id){
        $sql = "DELETE FROM users WHERE user_id = ?";
        $stmt = $this->conn->prepare($sql);

        if(!$stmt){
            return $this->queryFailed("Delete");
        } 
        $stmt->bind_param('s', $id);
        return $stmt->execute() ? $this->deletedResource() : $this->notFound();    
    }

    // Function to check fields for username and email
    private function checkFields(?string $username = null, ?string $email = null, string $type) : void {
        // Check if username is not empty
        if (empty($username) || $username === null) {
            $this->errors['usernameEdit'] = "Please fill the username";
        } else if ($this->validateUsername($this->checkUsername($username, $type))) {
            foreach($this->checkUsername($username, $type) as $type => $hasType){
                if($hasType) $this->errors['usernameValid'][$type] = $type . " is required";
            }
        } 
        // Check if email is not empty
        if (empty($email) || $email === null) {
            $this->errors['emailEdit'] = "Please fill the email";
        // Check if email is valid
        } else if (!$this->checkEmail($email)){
            $this->errors['emailEdit'] = "Please enter a valid email";
        }
    }

    // Function to check fields for username and email in creating user
    private function checkFieldsCreate(?string $username = null, ?string $email = null, string $type) : void {
        // Check if username is not empty
        if (empty($username) || $username === null || $username === "") {
            $this->errors['usernameCreate'] = "Please fill the username";
        } else if ($this->validateUsername($this->checkUsername($username, $type))) {
            foreach($this->checkUsername($username, $type) as $type => $hasType){
                if($hasType) $this->errors['usernameValid'][$type] = $type . " is required";
            }
        } 
        // Check if email is not empty
        if (empty($email) || $email === null || $email === "") {
            $this->errors['emailCreate'] = "Please fill the email";
        // Check if email is valid
        } else if (!$this->checkEmail($email)){
            $this->errors['emailCreate'] = "Please enter a valid email";
        }
    }

    // Function to check password fields for creating user
    private function checkPasswordFieldsCreate(?string $newPassword = null, ?string $confirmNewPassword = null) : void {
        // Check if new password is empty 
        if(empty($newPassword) && $newPassword === null) {
            $this->errors['passwordCreate'] = "Please fill the password";
        } 
    
        // Validate new password
        if($newPassword !== null && $this->validateAdminPassword($this->checkAdminPassword($newPassword))) {
            foreach($this->checkAdminPassword($newPassword) as $type => $hasType){
                if(!$hasType) $this->errors['passwordValid'][$type] = $type . " is required";
            }
        }
    
        // Check if new confirm password is empty
        if(empty($confirmNewPassword) && $confirmNewPassword === null) {
            $this->errors['confirmpasswordCreate'] = "Please fill the confirm password";
        }
    
        // Check if new password and confirm password match
        if($confirmNewPassword !== null && $confirmNewPassword !== $newPassword) {
            $this->errors['confirmpasswordCreate'] = "Password doesn't match";
        }
    }

    // Function to check password fields for changing password
    private function checkPasswordFields(string $id, ?string $newPassword = null, ?string $confirmNewPassword = null) : void {
        // Check if new password is empty 
        if(empty($newPassword) && $newPassword === null) {
            $this->errors['newpassword'] = "Please fill the password";
        } 
    
        // Validate new password
        if($newPassword !== null && $this->validateAdminPassword($this->checkAdminPassword($newPassword))) {
            foreach($this->checkAdminPassword($newPassword) as $type => $hasType){
                if(!$hasType) $this->errors['passwordValid'][$type] = $type . " is required";
            }
        }
    
        // Check if new password is the same as the current password
        if($newPassword !== null && $this->currentPassword($id, $newPassword)) {
            $this->errors['newpassword'] = "The password must not be the old one";
        }
    
        // Check if new confirm password is empty
        if(empty($confirmNewPassword) && $confirmNewPassword === null) {
            $this->errors['newconfirmpassword'] = "Please fill the confirm password";
        } 
    
        // Check if new password and confirm password match
        if($confirmNewPassword !== null && $confirmNewPassword !== $newPassword) {
            $this->errors['newconfirmpassword'] = "Password doesn't match";
        }
    }

    // Function to check password fields for deleting account
    private function check_Admin_Delete_Password_Fields(?string $password = null, ?string $confirmPassword = null) : void {
        // Check if new password is empty 
        if(empty($password) && $password === null) {
            $this->errors['password'] = "Please fill the password";
        } 
    
        // Check if new confirm password is empty
        if(empty($confirmPassword) && $confirmPassword === null) {
            $this->errors['confirmpassword'] = "Please fill the confirm password";
        } 
    
        // Check if new password and confirm password match
        if($confirmPassword !== null && $confirmPassword !== $password) {
            $this->errors['confirmpassword'] = "Password doesn't match";
        }
    }

    // Function to check if the new password is the same as the current password
    private function currentPassword(string $id, string $newPassword) : bool {
        $sql = "SELECT password FROM admin_users WHERE id = ?";
        $stmt = $this->conn->prepare($sql);
        $stmt->bind_param('s', $id);

        if(!$stmt){
            return false;
        }
        $stmt->execute();
        $result = $stmt->get_result();
        $row = $result->fetch_assoc();
        return password_verify($newPassword, $row['password']) ? true : false;
    }

    // Function to verify password
    private function verifyPassword(string $id, string $password) : bool {
        $sql = "SELECT password FROM admin_users WHERE id = ?";
        $stmt = $this->conn->prepare($sql);
        $stmt->bind_param('s', $id);

        if(!$stmt){
            return false;
        }
        $stmt->execute();
        $result = $stmt->get_result();
        $row = $result->fetch_assoc();
        return password_verify($password, $row['password']) ? true : false;
    }

    // Function to get change password query
    private function changePasswordQuery() : string {
        return "UPDATE admin_users SET password = ? WHERE id = ?";
    }

    // Function to get change theme admin query
    private function changeThemeAdminQuery(?string $type) : string {
        $switch = $type === "dark" ? 1 : 0;
        return "UPDATE admin_settings SET dark_mode = $switch, font_style = ? WHERE admin_id = ?";
    }

    // Function to check if email is valid
    private function checkEmail(string $email) : bool{
        $status = filter_var($email, FILTER_VALIDATE_EMAIL) ? true : false;
        return $status;
    }

    // Function to validate username
    private function validateUsername(array $username) : bool {
        foreach(array_keys($username) as $hastype){
            $status = $hastype ? true : false;
        }
        return $status;
    }

    // Function to check username based on type
    private function checkUsername(string $username, string $type) : array {
        $upperCase = !preg_match('/[A-Z]/', $username); 
        $lowerCase = !preg_match('/[a-z]/', $username); 
        $usernameLength = strlen($username) < 5;
        $specialchars = !preg_match('/[^A-Za-z0-9]/', $username);
        
        $errors = [
            "Uppercase" => $upperCase,
            "Lowercase" => $lowerCase,
            "5 characters" => $usernameLength
        ];

        if($type === "admin"){
            $errors['Special characters'] = $specialchars;
        }
        return $errors;
    }

    // Function to validate admin password
    private function validateAdminPassword(array $password) : bool {
        foreach (array_keys($password) as $hasType){
            $status = $hasType ? true : false;
        }
        return $status;
    }

    // Function to check admin password
    private function checkAdminPassword(string $newPassword) : array {
        $uppercase = preg_match('/[A-Z]/', $newPassword);
        $lowercase = preg_match('/[a-z]/', $newPassword);
        $specialchars = preg_match('/[^A-Za-z0-9]/', $newPassword);
        $numericVal = preg_match('/[0-9]/', $newPassword);

       return [
            "Uppercase" => $uppercase,
            "Lowercase" => $lowercase,
            "Special characters" => $specialchars,
            "Numeric value" => $numericVal
       ];
    }

    // Function to change admin image
    private function changeImage(string $id, $image = null) : bool {
        if($image === null){
            return false;
        }

        $fileName = $image['name'] ?? null;
        $fileSize = $image['size'] ?? null;
        $fileTmpName = $image['tmp_name'] ?? null;
        $fileError = $image['error'] ?? null;
        $fileExt = explode('.', $fileName);
        $fileActualExt = strtolower(end($fileExt));
        $fileNameNew = uniqid('', true) . "." . $fileActualExt;
        $targetDirectory = $this->imageConfig['admins'] . $fileNameNew; 
        
        $allowed = array("jpeg", "png", "jpg");
    
        if ($fileError !== UPLOAD_ERR_OK) {
            $this->errors['imageEdit'] = 'Error Uploading Image!';
        }
    
        if (!in_array($fileActualExt, $allowed)) {
            $this->errors['imageEdit'] = 'Invalid Extension!';
        } 
    
        if ($fileSize > 5000000) {
            $this->errors['imageEdit'] = 'Image size too big!';
        }

        if(!empty($this->errors)){
            return false;
        }

        if(!move_uploaded_file($fileTmpName, $targetDirectory)) {
            $this->errors['imageEdit'] = 'Failed to upload image';
            return false;
        }

        $this->deleteExistingImage($id);
        $sql = "UPDATE admin_users SET image_src = ? WHERE id = ?";
        $stmt = $this->conn->prepare($sql);

        if(!$stmt){
            return false;
        }

        $stmt->bind_param('ss', $fileNameNew, $id);
        $stmt->execute();

        return $stmt->affected_rows > 0 ? true : false;
    }

    // Function to delete existing image
    private function deleteExistingImage(string $id) : void {
        $sql = "SELECT image_src FROM admin_users WHERE id = ?";
        $stmt = $this->conn->prepare($sql);
        $stmt->bind_param('s', $id);

        if(!$stmt) {
            $this->queryFailed();
        }

        $stmt->execute();
        $result = $stmt->get_result();
        $row = $result->fetch_assoc();
        $image = $row['image_src'];

        if($result->num_rows > 0){
            if($image !== null){
                unlink($this->imageConfig['admins'] . $image);
            } 
        }
    }

    // Function to create users image
    private function createImage($image = null) : ?string {

        $fileName = $image['name'] ?? null;
        $fileSize = $image['size'] ?? null;
        $fileTmpName = $image['tmp_name'] ?? null;
        $fileError = $image['error'] ?? null;
        $fileExt = explode('.', $fileName);
        $fileActualExt = strtolower(end($fileExt));
        $fileNameNew = uniqid('', true) . "." . $fileActualExt;
        $targetDirectory = $this->imageConfig['users'] . $fileNameNew; 
        
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