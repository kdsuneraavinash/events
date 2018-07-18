<?php
  // Original Ref: https://www.tutorialspoint.com/php/php_mysql_login.htm
   session_start();

   if($_SERVER["REQUEST_METHOD"] == "POST") {
      // username and details sent from ajax 
      if (isset($_SESSION['uid']) && $_POST['uid'] == $_SESSION['uid']){
        // Login an already logged in user 
        // This user is same as previously logged in user
        // Dont Refresh or set _SESSION
        echo "session-already-set";
      }else{
        // Login a not logged in user or this user is different from logged in user
        $_SESSION['email'] = $_POST['email'];
        $_SESSION['displayName'] = $_POST['displayName'];
        $_SESSION['uid'] = $_POST['uid'];
        echo "session-set-refresh";
      }
      
   }
?>
