<?php
   session_start();

    if (isset($_SESSION['uid'])){
        // Login an already logged in user 
        // Logout and refresh
        // remove all session variables
        session_unset();
        // destroy the session
        session_destroy(); 
        echo "session-deleted-refresh";
      }else{
        // Login a not logged in user
        // Do nothing
        echo "session-not-present";
      }
      
?>
