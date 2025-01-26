<?php
require_once('../api/apiStatus.php');
require '../vendor/autoload.php';
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

class Recover extends Api {
    private $email;
    private $password;
    private $confirm_password;
    private $emailVerified;
    public $errors = array();

    // Constructor to initialize email, password, and confirm_password
    public function __construct(?string $email = null, ?string $password = null, ?string $confirm_password = null, string $emailVerified = "false"){
        $this->conn = $this->connect();
        $this->email = $email;
        $this->password = $password;
        $this->confirm_password = $confirm_password;
        $this->emailVerified = $emailVerified;
    }

    // Function to send verification email
    public function sendVerificationEmail(string $email, string $verification_code) : void {
        $mail = new PHPMailer(true);
        try {
            // Server settings
            $mail->isSMTP();
            $mail->Host = 'smtp.gmail.com';
            $mail->SMTPAuth = true;
            $mail->Username = 'merinojc25@gmail.com';
            $mail->Password = 'galglubgqbibygqz';
            $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
            $mail->Port = 587;

            // Recipients
            $mail->setFrom('merinojc25@gmail.com', 'GreekMythCMS');
            $mail->addAddress($email);

            // Content
            $mail->isHTML(true);
            $mail->Subject = 'Verification Code to Recover Account';
            $mail->Body = "
                <html>
                <head>
                    <style>
                        .container {
                            font-family: Arial, sans-serif;
                            text-align: center;
                            padding: 20px;
                            border: 1px solid #ddd;
                            border-radius: 10px;
                            background-color: #f9f9f9;
                        }
                        .code {
                            font-size: 24px;
                            font-weight: bold;
                            color: #333;
                        }
                        .footer {
                            margin-top: 20px;
                            font-size: 12px;
                            color: #777;
                        }
                    </style>
                </head>
                <body>
                    <div class='container'>
                        <h2>Verification Code</h2>
                        <p>Your verification code is:</p>
                        <p class='code'>$verification_code</p>
                        <div class='footer'>
                            <p>If you did not request this code, please ignore this email.</p>
                        </div>
                    </div>
                </body>
                </html>
            ";

            $mail->send();
            $this->storeVerificationCode($email, $verification_code); // Store the verification code in the database

            // Response for successful email sending
            $response = array(
                "status" => 200,
                "message" => "Code sent successfully!",
            );
            echo json_encode($response);
        } catch (Exception $e) {
            // Handle email sending error
            $this->errors['code'] = 'Send Code Failed!';
            $response = array(
                "status" => 422,
                "message" => "Unprocessable Content",
                "error" => $this->errors,
                "details" => $e->getMessage()
            );
            echo json_encode($response);
        }
    }

    // Function to verify the code
    public function verifyCode(string $email, string $verification_code) : void {
        $sql = "SELECT * FROM verification_codes WHERE email = ? AND code = ?";
        $stmt = $this->conn->prepare($sql);

        if(!$stmt) {
            $this->errors['code'] = 'Verification Failed!';
            $response = array(
                "status" => 422,
                "message" => "Unprocessable Content",
                "error" => $this->errors
            );
            echo json_encode($response);
            return;
        }

        $stmt->bind_param('ss', $email, $verification_code);
        $stmt->execute();
        $result = $stmt->get_result();

        if($result->num_rows > 0) {
            $this->deleteVerificationCode($email);
            $response = array(
                "status" => 200,
                "message" => "Email verified successfully!",
            );
        } else {
            $this->errors['code'] = 'Invalid verification code!';
            $response = array(
                "status" => 422,
                "message" => "Unprocessable Content",
                "error" => $this->errors
            );
        }
        echo json_encode($response);
    }

    // Function to recover account
    public function recoverAcc() : string {
        $this->checkRecoverFields();

        if(!empty($this->errors)){
            return $this->queryFailed("Edit", $this->errors);
        }

        $sql = $this->recoverAccQuery();
        $stmt = $this->conn->prepare($sql);

        if(!$stmt){
            return $this->queryFailed();
        } 
        
        $this->password = password_hash($this->password, PASSWORD_DEFAULT);
        $stmt->bind_param('ss', $this->password, $this->email);
        $stmt->execute();
        return $stmt->affected_rows > 0 ? $this->editedResource() : $this->notFound();

    }

    // Function to verify email
    public function verifyEmail(?string $email = null) : string {
        $sql = $this->verifyEmailQuery();
        $stmt = $this->conn->prepare($sql);
        
        if(!$stmt){
            return $this->queryFailed();
        }

        $stmt->bind_param('s', $email);
        $stmt->execute();
        $result = $stmt->get_result();

        if($result->num_rows > 0){
            return $this->emailVerified($email);
        }

        if(empty($email) || is_null($email)){
            $this->errors['code'] = 'Please enter your email';
        } else {
            $this->errors['code'] = "Email doesn't exist!";
        }

        return $this->queryFailed("Edit", $this->errors);
    }

    // Function to check recovery fields
    private function checkRecoverFields() : void {
        if(empty($this->email) || !isset($this->email)){
            $this->errors['email'] = "Please fill the email";
        } else if (!$this->validateEmail($this->email)) {
            $this->errors['email'] = "Invalid email address";
        } else if($this->emailVerified === "false"){
            $this->errors['email'] = "Email not verified!";
        }

        if(empty($this->password) || !isset($this->password)){
            $this->errors['password'] = "Please fill the password";
        } else if($this->validatePassword($this->checkPassword($this->password))) {
            foreach($this->checkPassword($this->password) as $type => $hasType){
                if(!$hasType) $this->errors['passwordValid'][$type] = $type . " is required";
            }
        }

        if(empty($this->confirm_password) || !isset($this->confirm_password)) {
            $this->errors['confirm_password'] = "Please fill the confirm password";
        } else if ($this->confirm_password != $this->password) {
            $this->errors['confirm_password'] = "Password does not match";
        }
    }

    // Function to store verification code in the database
    private function storeVerificationCode(string $email, string $verification_code) : void {
        $sql = "INSERT INTO verification_codes (id, email, code) VALUES (UUID(), ?, ?)";
        $stmt = $this->conn->prepare($sql);

        if(!$stmt) {
            $this->errors['code'] = 'Failed to store verification code!';
            return;
        }

        $stmt->bind_param('ss', $email, $verification_code);
        $stmt->execute();
    }

    private function deleteVerificationCode(string $email) : void {
        $sql = "DELETE FROM verification_codes WHERE email = ?";
        $stmt = $this->conn->prepare($sql);

        if(!$stmt){
            echo $this->queryFailed();
        }

        $stmt->bind_param('s', $email);
        $stmt->execute();
    }

    // Query to verify email
    private function verifyEmailQuery() : string {
        return "SELECT email FROM admin_users WHERE email = ?";
    }

    // Query to recover account
    private function recoverAccQuery() : string {
        return "UPDATE admin_users SET password = ? WHERE email = ?";
    }

    // Function to validate email format
    private function validateEmail(string $email) : bool {
        $status = filter_var($email, FILTER_VALIDATE_EMAIL) ? true : false;
        return $status;
    }

    // Function to validate password
    private function validatePassword(array $password) : bool {
        foreach (array_keys($password) as $hasType){
            $status = $hasType ? true : false;
        }
        return $status;
    }

    // Function to check password requirements
    private function checkPassword(string $password) : array {
        $uppercase = preg_match('/[A-Z]/', $password);
        $lowercase = preg_match('/[a-z]/', $password);
        $specialchars = preg_match('/[^A-Za-z0-9]/', $password);
        $numericVal = preg_match('/[0-9]/', $password);

       return [
            "Uppercase" => $uppercase,
            "Lowercase" => $lowercase,
            "Special characters" => $specialchars,
            "Numeric value" => $numericVal
       ];
    }
}
?>