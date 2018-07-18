<?php
  // get login information
  // loggedIn -> Whether logged in
  // user -> User Info (null if not loggef in)
  $loggedIn = isset($_SESSION["uid"]);
  if ($loggedIn){
    $user = $_SESSION;
  }else{
    $user = null;
  }

  // Get page name and load module/pages details
  $fullPath = $_SERVER['PHP_SELF'];
  $endIndex = strpos($fullPath, '.php');
  $startIndex = strrpos($fullPath, '/');
  $currentPage = substr($fullPath, $startIndex + 1, $endIndex - $startIndex - 1);
  $loadFirestore = ($currentPage == "addevent" || $currentPage == "events");
  $loadImageView = ($currentPage == "post");
  $loadFormTools = ($currentPage == "addevent");
  
  // Dynamically create Navigation Bar Item
  function createNavBarItem($page, $title){
    global $currentPage;
    $isActivePage = ($currentPage == $page);
    $activeTag = $isActivePage ? "active" : "";
    $link = $isActivePage ? "#" : "$page.php";
    echo "
    <li class='nav-item $activeTag'>
      <a class='nav-link mx-2 px-2 my-1' href='$link'>$title
      </a>
    </li>
    ";
  }

  function createAccountButton($icon, $modal, $text){
    echo "
      <li class='mx-1'>
        <button class='form-inline btn btn-outline-light btn-block mb-1 account-button' type='button' data-toggle='modal' data-target='$modal'>
          <span class='$icon m-2'></span>
          $text
        </button>
      </li>
    ";
  }

  function createContactCard($name, $position, $email, $image){
    echo "<div class='col-sm card'>
          <img src='$image' alt='$name' class='img-fluid card-img-top rounded-circle img-thumbnail' />
          <h4 class='card-title'>$name</h4>
          <h6 class='card-subtitle mb-2 text-muted'>$position</h6>
          <button class='btn btn-primary' onclick=\"location.href='mailto:$email';\" >Contact</button>
        </div>";
    }

    function createCarousalItem($src, $caption, $description, $activeTag){
      echo "
      <div class='carousel-item $activeTag'>
        <img class='d-block w-100' src='$src' alt='$caption'>
        <div class='carousel-caption d-none d-md-block'>
          <h5>$caption</h5>
          <p>$description</p>
        </div>
      </div>
      ";
    }
?>
