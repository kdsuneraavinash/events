<?php include("header.php"); 

function createCard($name, $position, $email, $image){
  echo "<div class='col-sm card'>
        <img src='$image' alt='$name' class='img-fluid card-img-top rounded-circle img-thumbnail' />
        <h4 class='card-title'>$name</h4>
        <h6 class='card-subtitle mb-2 text-muted'>$position</h6>
        <button class='btn btn-primary' onclick=\"location.href='mailto:$email';\" >Contact</button>
      </div>";
  }
?>

<div class="container">
  <div class="card content" id="about_us_text">

    <h2 class="card-title text-center">About Us</h2>
    <hr />

    <div class="row">
      <div class="col-sm text-center">
        <img id="logo_img" class="img-fluid" src="images/axys_logo.jpg" alt="Axys Logo" />
      </div>
      <div class="col-sm jumbotron" style="background-color:white">
        <p class="lead">
          <span class="fas fa-at small-icon"></span>teamaxys@gmail.com
          <br />
          <span class="fas fa-phone small-icon"></span>087-11227890
          <br />
          <span class="fas fa-user-graduate small-icon"></span>University of Moratuwa
        </p>
        <button class='btn btn-primary w-100' onclick="location.href='mailto:teamaxys@gmail.com';">Contact</button>
      </div>
    </div>

    <hr />
    <h2 class="card-title text-center">Team Members</h2>
    <hr />

    <div class="row">
      <?php
      createCard("Sunera Avinash", "CTO & Lead Programmer", "kdsuneraavinash@gmail.com", "images/sunera_avinash.jpg");
      createCard("Deepana Ishtaweera", "CEO", "deepanaishtaweera174@gmail.com", "images/deepana_ishtaweera.jpg");
      createCard("Dinith Herath", "Product Manager", "dinithherath18332@gmail.com", "images/dinith_herath.jpg");
      ?>
    </div>
    <div class="row">
      <?php
      createCard("Ruchin Amarathunga", "COO", "raruchin@gmail.com", "images/ruchin_amarathunga.jpg");
      createCard("Uvindu Avishka", "Head of Marketing", "uvinduavishka@gmail.com", "images/uvindu_avishka.jpg");
      createCard("Ravikula Silva", "Head of Creative Design", "ravikulas@gmail.com", "images/ravikula_silva.jpg");
      ?>
    </div>

  </div>
</div>

<?php include("footer.php"); ?>