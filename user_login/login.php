<?php
  // Original Ref: https://www.tutorialspoint.com/php/php_mysql_login.htm
   session_start();

   if($_SERVER["REQUEST_METHOD"] == "POST") {
      // username and password sent from form 
      $email = $_POST['email'];
      $displayName = $_POST['displayName'];
      $photoURL = $_POST['photoURL'];
      $uid = $_POST['uid'];

      if (isset($_SESSION['user'])){
        // Login an already logged in user (Maybe first log in)
        // Dont Refresh or set _SESSION
        // TODO: Check whether _SESSION user and post user is same
        echo "no-refresh";
      }else{
        // Login a not logged in user
        $_SESSION['user'] = $email;
        $_SESSION['society'] = $displayName;
        $_SESSION['photo'] = $photoURL;
        $_SESSION['uid'] = $uid;
        echo "refresh";
      }
      
   }
?>
