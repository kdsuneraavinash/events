<?php
  // Original Ref: https://www.tutorialspoint.com/php/php_mysql_login.htm
   session_start();
    // remove all session variables
    session_unset();

    // destroy the session
    session_destroy(); 
    header("location: ../index.php");
?>
