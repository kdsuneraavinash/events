<?php
  // Start the session
  session_start();

  // Class to store session info in more convienient manner
  require('public_functions.php');
?>

  <!DOCTYPE html>
  <html lang="en">

  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Make mobile friendly-->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Mora Events</title>
    <!-- Add icon -->
    <link rel="icon" href="https://cdn1.iconfinder.com/data/icons/flat-business-icons/128/calendar-512.png">

    <!-- Add bootstrap CDN-->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css" integrity="sha384-Smlep5jCw/wG7hdkwQ/Z5nLIefveQRIY9nfy6xoR1uRYBtpZgI6339F5dgvm/e9B"
      crossorigin="anonymous">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.0/css/solid.css" integrity="sha384-TbilV5Lbhlwdyc4RuIV/JhD8NR+BfMrvz4BL5QFa2we1hQu6wvREr3v6XSRfCTRp"
      crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.0/css/fontawesome.css" integrity="sha384-ozJwkrqb90Oa3ZNb+yKFW2lToAWYdTiF1vt8JiH5ptTGHTGcN7qdoR1F95e0kYyG"
      crossorigin="anonymous">
    <!-- Add Stylesheets -->
    <link rel="stylesheet" href="css/animations.css" />
    <link rel="stylesheet" href="css/stylesheet.css" />

    <!-- JQuery CDN -->
    <script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
      crossorigin="anonymous"></script>
    <!-- Firebase - Must come before all script tags-->
    <!-- Firebase App is always required and must be first -->
    <script src="https://www.gstatic.com/firebasejs/5.2.0/firebase-app.js"></script>
    <script src="https://www.gstatic.com/firebasejs/5.2.0/firebase-auth.js"></script>
    <?php if ($currentPage == "showevent" || $currentPage == "post" || $currentPage == "events")
      echo "<script src='https://www.gstatic.com/firebasejs/5.2.0/firebase-firestore.js'></script>"; 
    ?>
    <script src="js/api-keys.js"></script>
    <script src="js/firebase-init.js"></script>
  </head>

  <body>

    <noscript>
      <?php include("error/no-javascript.html");?>
    </noscript>

    <!-- Navigation bar -->
    <nav class="navbar navbar-expand-lg navbar-dark mb-4 px-4 justify-content-between fixed-top" id="navbar">
      <a class="navbar-brand" href="#">Mora Events</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarText" aria-controls="navbarText"
        aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarText">
        <ul class="navbar-nav mr-auto">

          <?php
            createNavBarItem(['index'], 'Home');
            createNavBarItem(['events', 'showevent'], 'Events');
            createNavBarItem(['addevent'], 'Add Event');
            createNavBarItem(['about'], 'About');
          ?>

        </ul>
        <ul class="nav navbar-nav navbar-right row my-3 mx-2">
          <!-- Switch between Login and Logout button depending on 
              user login information -->
          <?php 
              if ($loggedIn){
                $email = $user["email"];
                createAccountButton('fas fa-sign-out-alt', '#logoutForm', "$email");
              }else{
                createAccountButton('fas fa-sign-in-alt', '#loginForm', 'Sign In');
                createAccountButton('fas fa-user-plus', '#signupNotice', 'Sign Up');
              }
            ?>

        </ul>
      </div>
    </nav>

    <!-- Include only necessary file depending on whether user is logged in or not -->
    <?php 
      if (!$loggedIn){
        include_once("model_forms/login_form.html"); 
        include_once("model_forms/signup_notice.html");
      }else{
        include_once("model_forms/logout_form.html"); 
      }

      switch ($currentPage){
        case "showevent":
          include_once("model_forms/imageview.html"); 
          include_once("model_forms/loading_data.html"); 
          break;
        case "events":
        case "post":
          include_once("model_forms/loading_data.html"); 
          break;
        case "addevent":
          include_once("model_forms/msgbox.html"); 
          break;
      }

    ?>