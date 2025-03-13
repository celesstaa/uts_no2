<?php
session_start();
require('./conection.php'); // Pastikan koneksi database benar

$message = "";

if (isset($_POST['login_button'])) {  // Hanya memproses jika tombol ditekan
    $_SESSION['validate'] = false;

    $name = $_POST['name'] ?? '';
    $course_name = $_POST['course'] ?? '';

    if (!empty($name) && !empty($course_name)) {
        try {
            $db = crud::conect();
            $p = $db->prepare('SELECT * FROM registrations WHERE name = :n AND course_name = :c');
            $p->bindValue(':n', $name);
            $p->bindValue(':c', $course_name);
            $p->execute();

            if ($p->rowCount() > 0) {
                $message = "Anda sudah terdaftar dalam kursus ini!";
            } else {
                $insert = $db->prepare('INSERT INTO registrations (name, course_name) VALUES (:n, :c)');
                $insert->bindValue(':n', $name);
                $insert->bindValue(':c', $course_name);

                if ($insert->execute()) {
                    $_SESSION['name'] = $name;
                    $_SESSION['course'] = $course_name;
                    $_SESSION['validate'] = true;
                    $message = "Data Anda telah tersimpan!";
                } else {
                    $message = "Gagal menyimpan data, coba lagi!";
                }
            }
        } catch (PDOException $e) {
            $message = "Error: " . $e->getMessage();
        }
    } else {
        $message = "Nama dan Course tidak boleh kosong!";
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up</title>
    <style>
        body {
            background-color: rgb(83, 15, 148);
            margin: 0;
            font-family: Arial, sans-serif;
        }
        .header {
            width: 100%;
            position: fixed;
            top: 0;
            left: 0;
            padding: 20px 0;
            background-color: rgb(83, 15, 148);
            text-align: center;
            color: white;
            font-size: 28px;
            font-weight: bold;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            z-index: 1000;
        }
        .form {
            width: 250px;
            padding: 20px;
            background: white;
            border-radius: 10px;
            margin: 100px auto 0;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
            text-align: center;
        }
        input, select {
            width: 100%;
            padding: 8px;
            margin: 10px 0;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        input[type="submit"] {
            background-color: rgb(83, 15, 148);
            color: white;
            border: none;
            cursor: pointer;
        }
        .message {
            margin-top: 10px;
            font-size: 14px;
            color: green;
        }
        a {
            display: block;
            margin-top: 10px;
            font-size: 14px;
            text-decoration: none;
            color: rgb(83, 15, 148);
        }
    </style>
</head>
<body>
    <div class="form">
        <div class="title">
            <p>Login Form</p>
        </div>
        <form action="" method="post">
            <input type="text" name="name" placeholder="Name" required>
            <select name="course" required>
                <option value="">Pilih Course</option>
                <option value="python">Pemrograman Python</option>
                <option value="sql">Basis Data SQL</option>
                <option value="javascript">JavaScript Pemula</option>
                <option value="machine_learning">Machine Learning Dasar</option>
                <option value="Keamanan Siber">Keamanan Siber</option>
                <option value="HTML & CSS">HTML & CSS</option>
                <option value="Data Science">Data Science</option>
            </select>
            <input type="submit" value="Registration" name="login_button"> 
        </form>
        <?php 
        if (isset($_POST['login_button']) && !empty($message)) { 
            echo "<p class='message'>$message</p>"; 
        } 
        ?>
        <a href="./signUP.php">Click here to sign up</a>
    </div>
</body>
</html>
