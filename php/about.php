<?php include("header.php"); ?>

<div class="container">
  <div class="card content" id="about_us_text">

    <h2 class="card-title text-center">About Us</h2>
    <hr />

    <div class="row slideanim">
      <div class="col-lg text-center">
        <img id="logo_img" class="img-fluid" src="images/axys_logo.jpg" alt="Axys Logo" />
      </div>
      <div class="col-lg jumbotron" style="background-color:white">
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
    <div class="slideanim">
      <p class="blockquote ">
        Team Axys is a group of passionate young individuals who are trying to discover new horizons through technology. We have
        already made our mark at UOM and now looking to extend our service to a wider community. Stay tuned for more of our
        products.
      </p>
    </div>
    <hr />

    <div class="slideanim">
      <hr />
      <h2 class="card-title text-center">Team Members</h2>
      <hr />
    </div>


    <div class="row">
      <?php
      createContactCard("Sunera Avinash", "CTO & Lead Programmer", "kdsuneraavinash@gmail.com", "images/sunera_avinash.jpg");
      createContactCard("Deepana Ishtaweera", "CEO", "deepanaishtaweera174@gmail.com", "images/deepana_ishtaweera.jpg");
      createContactCard("Dinith Herath", "Product Manager", "dinithherath18332@gmail.com", "images/dinith_herath.jpg");
      ?>
    </div>
    <div class="row">
      <?php
      createContactCard("Ruchin Amarathunga", "COO", "raruchin@gmail.com", "images/ruchin_amarathunga.jpg");
      createContactCard("Uvindu Avishka", "Head of Marketing", "uvinduavishka@gmail.com", "images/uvindu_avishka.jpg");
      createContactCard("Ravikula Silva", "Head of Creative Design", "ravikulas@gmail.com", "images/ravikula_silva.jpg");
      ?>
    </div>

  </div>
</div>

<?php include("footer.php"); ?>