<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./sign.css">
    <title>Sign Up</title>
</head>
<body>
    <?php
        require('./conection.php');

        if (isset($_POST['signUP_button'])) {
            $name = trim($_POST['name']);
            $username = trim($_POST['username']);
            $email = trim($_POST['email']);
            $password = $_POST['password'];
            $confPassword = $_POST['confiPassword'];

            // Validasi input tidak boleh kosong
            if (!empty($name) && !empty($username) && !empty($email) && !empty($password)) {
                // Validasi email
                if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
                    echo "Invalid email format!";
                } else {
                    // Cek apakah password dan konfirmasi cocok
                    if ($password === $confPassword) {
                        // Hash password sebelum disimpan
                        $hashedPassword = password_hash($password, PASSWORD_DEFAULT);

                        // Cek apakah email sudah terdaftar
                        $checkEmail = crud::conect()->prepare("SELECT * FROM users WHERE email = :email");
                        $checkEmail->bindValue(':email', $email);
                        $checkEmail->execute();

                        if ($checkEmail->rowCount() > 0) {
                            echo "Email already exists!";
                        } else {
                            // Simpan data ke database
                            $p = crud::conect()->prepare('INSERT INTO users (name,username, email, password, role) VALUES (:n,:u, :e, :p, "student")');
                            $p->bindValue(':n', $name);
                            $p->bindValue(':u', $username);
                            $p->bindValue(':e', $email);
                            $p->bindValue(':p', $hashedPassword);
                            $p->execute();

                            echo "User added successfully!";
                        }
                    } else {
                        echo "Passwords do not match!";
                    }
                }
            } else {
                echo "All fields are required!";
            }
        }
    ?>

    <div class="form">
        <div class="title">
            <p>Sign Up Form</p>
        </div>
        <form action="" method="post">
            <input type="text" name="name" placeholder="Name" required>
            <input type="text" name="username" placeholder="Username" required>
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="password" name="confiPassword" placeholder="Confirm Password" required>
            
            <input type="submit" value="Sign Up" name="signUP_button"> 
            <a href="./login.php">Already have an account? Sign in</a>
        </form>
    </div>
</body>
</html>
