<?php
require_once('../api/apiStatus.php');

class Login extends Api {
    public $errors = array();

    public function __construct(){
        $this->conn = $this->connect();
    }

    public function login(string $usernameOrEmail, string $password) : string {
        try {
            $sql = "SELECT admin_users.*, admin_settings.dark_mode , admin_settings.font_style
            FROM Admin_Users JOIN Admin_Settings ON
            admin_users.id = admin_settings.admin_id
            WHERE admin_users.username = ? OR admin_users.email = ?";
            $stmt = $this->conn->prepare($sql);

            if (!$stmt) {
                throw new Exception('Failed to prepare SQL statement.');
            }

            $stmt->bind_param('ss', $usernameOrEmail, $usernameOrEmail);
            $stmt->execute();
            $result = $stmt->get_result();

            if ($result->num_rows > 0) {
                $row = $result->fetch_assoc();

                if (password_verify($password, $row['password'])) {

                    $data = array();
                    $token = bin2hex(random_bytes(32));
                    $data['token'] = $token;
                    $data['user_id'] = $row['id'];
                    $data['theme'] = $row['dark_mode'];
                    $data['font_style'] = $row['font_style'];

                    $sql = "UPDATE Admin_Users SET token = ?, verified = 1 WHERE id = ?";
                    $stmt = $this->conn->prepare($sql);

                    if(!$stmt){
                        return $this->queryFailed();
                    } else {
                        $stmt->bind_param('ss', $token, $row['id']);
                        $stmt->execute();
                        $response = array(
                            'status' => 200,
                            'message' => 'Logged in as '. $row['username'],
                            'data' => $data
                        );
                        $stmt->close();
                        $this->conn->close();
                        header('HTTP/1.1 200 OK');
                        return json_encode($response);
                    }
                } else {
                    throw new Exception('Incorrect password.');
                }
            } else {
                throw new Exception('User not found.');
            }
        } catch (Exception $e) {
            $errors['auth_status'] = $e->getMessage();
            $response = [
                'status' => 401,
                'message' => 'Authentication failed',
                'error' => $errors
            ];
            header('HTTP/1.1 401 Unauthorized');
            return json_encode($response);
        }
    }

    public function logout($token) : string {
        $sql = "UPDATE Admin_Users SET token = null, verified = 0 WHERE token = ?";
        $stmt = $this->conn->prepare($sql);

        if(!$stmt) {
            return $this->queryFailed();
        } else {
            $stmt->bind_param('s', $token);
            $status = $stmt->execute() ? $this->success() : $this->queryFailed();
            return $status;
        }
    }


}

?>