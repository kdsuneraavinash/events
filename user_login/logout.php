<?php
   session_start();

    if (isset($_SESSION['user'])){
        // Login an already logged in user 
        // Logout and refresh
        // remove all session variables
        session_unset();
        // destroy the session
        session_destroy(); 
        echo "refresh";
      }else{
        // Login a not logged in user
        // Do nothing
        echo "no-refresh";
      }
      
?>
