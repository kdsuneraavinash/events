<?php
  // Start the session
  session_start();
?>

  <?php
  // get whether or not to in a page
  function isOnPage($check){
    return $_SERVER['PHP_SELF'] == "/$check.php";
  }

  // get whether or not to addactive tag depending on current page
  function getActiveTag($check){
    $str = isOnPage($check) ? ' active' : '';
    return $str;
  }
?>

    <?php
  // get login information
  $loggedIn = isset($_SESSION["user"]);
  if ($loggedIn){
    $user = $_SESSION["user"];
    $society = $_SESSION["society"];
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
        <!-- Add Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
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
              <?php
          if ($loggedIn){
            $activeTag = getActiveTag("addevent");
            echo '<li class="nav-item '.$activeTag.'">
                    <a class="nav-link mx-2 px-2 my-1" href="addevent.php">Add Event</a>
                  </li>';
                }
                ?>

                <li class="nav-item <?php echo getActiveTag('about');?>">
                  <a class="nav-link mx-2 px-2 my-1" href="about.php">About</a>
                </li>
            </ul>
            <ul class="nav navbar-nav navbar-right row my-3 mx-2">
              <li>
                <!-- Switch between Login and Logout button depending on 
            user login information -->
                <?php 
              if ($loggedIn){
                echo "<button class='form-inline btn btn-outline-light btn-block mx-0 mb-1' type='button' data-toggle='modal' data-target='#logoutForm'>
                        <span class='fas fa-sign-out-alt m-2'></span>
                          $user (logout)
                      </button>";
              }else{
                echo "<button class='form-inline btn btn-outline-light btn-block mx-0 mb-1' type='button' data-toggle='modal' data-target='#loginForm'>
                        <span class='fas fa-sign-in-alt m-2'></span>
                          Sign In
                      </button>";
              }
            ?>
                <li>
            </ul>
          </div>
        </nav>

        <!-- Include only necessary file depending on whether user is logged in or not -->
        <?php 
    if (!$loggedIn){
      include("login_form.php"); 
    }else{
      include("logout_form.php"); 
    }
  ?>