<?php
  // Start the session
  session_start();

  // get login information
  $loggedIn = isset($_SESSION["user"]);
  if ($loggedIn){
    $user = $_SESSION["user"];
    $society = $_SESSION["society"];
  }

  // get whether or not to in a page
  function isOnPage($check){
    return $_SERVER['PHP_SELF'] == "/$check.php" || 
    $_SERVER['PHP_SELF'] == "/moraevents/$check.php";
  }

  // get whether or not to addactive tag depending on current page
  function getActiveTag($check){
    $str = isOnPage($check) ? ' active' : '';
    return $str;
  }

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

    <!-- Firebase - Must come before all script tags-->
    <!-- Firebase App is always required and must be first -->
    <script src="https://www.gstatic.com/firebasejs/5.2.0/firebase-app.js"></script>
    <script src='https://www.gstatic.com/firebasejs/5.2.0/firebase-firestore.js'></script>
    <script src="https://www.gstatic.com/firebasejs/5.2.0/firebase-auth.js"></script>
    <script src="js/api-keys.js"></script>
    <script src="js/firebase-init.js"></script>
  </head>

  <body>
    <!-- Navigation bar -->
    <nav class="navbar navbar-expand-lg navbar-dark mb-4 px-4 justify-content-between fixed-top" id="navbar">
      <a class="navbar-brand" href="#">Mora Events</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarText" aria-controls="navbarText"
        aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarText">
        <ul class="navbar-nav mr-auto">
          <li class="nav-item <?php echo getActiveTag('index');?>">
            <a class="nav-link mx-2 px-2 my-1" href="index.php">Home
            </a>
          </li>
          <li class="nav-item <?php echo getActiveTag('addevent');?>">
            <a class="nav-link mx-2 px-2 my-1" href="addevent.php">Add Event</a>
          </li>
          <li class="nav-item <?php echo getActiveTag('about');?>">
            <a class="nav-link mx-2 px-2 my-1" href="about.php">About</a>
          </li>
        </ul>
        <ul class="nav navbar-nav navbar-right row my-3 mx-2">
          <!-- Switch between Login and Logout button depending on 
              user login information -->
          <?php 
              if ($loggedIn){
                echo "<li>
                        <button class='form-inline btn btn-outline-light btn-block mx-0 mb-1' type='button' data-toggle='modal' data-target='#logoutForm'>
                          <span class='fas fa-sign-out-alt m-2'></span>
                          $user (logout)
                        </button>
                        </li>";
              }else{
                echo "<li class='mx-1'>
                        <button class='form-inline btn btn-outline-light btn-block mb-1' type='button' data-toggle='modal' data-target='#loginForm'>
                          <span class='fas fa-sign-in-alt m-2'></span>
                          Sign In
                        </button>
                      </li>
                      <li class='mx-1'>
                        <button class='form-inline btn btn-outline-light btn-block mb-1' type='button' data-toggle='modal' data-target='#signupNotice'>
                          <span class='fas fa-user-plus m-2'></span>
                          Sign Up
                        </button>
                      </li>";
              }
            ?>
        </ul>
      </div>
    </nav>

    <!-- Include only necessary file depending on whether user is logged in or not -->
    <?php 
      if (!$loggedIn){
        include("model_forms/login_form.php"); 
        include("model_forms/signup_notice.php");
      }else{
        include("model_forms/logout_form.php"); 
      }

      if (isOnPage("post")){
        include("model_forms/imageview.php"); 
      }
    ?>