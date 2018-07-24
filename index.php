<?php include("header.php"); ?>

<div class="content">

  <div class="container-fluid index-headimage">
    <div class="text-center text-white index-caption slideanim">
      <h1>Mora Events </h1>
      <br/> Struggling to keep a track of your favourite events
      <br/>happening at UOM?
      <br/>Let us guide you through....
      <br/>
      <br/>
      <button id="getstarted" class="btn btn-primary">Get Started</button>
    </div>
  </div>

  <div class="row">
    <div class="index-desc1 col-md text-justify text-white">
      <div class="index-desc slideanim">
        Over the years University of Moratuwa has produced a number of outstanding professionals who have made an immense contribution
        to the nation. UOM further extends its service to the society by offering a wide rage extra curricular activities
        and events for its under graduates which would ultimately build well balanced personalities.
      </div>
    </div>
    <div class="index-desc2 col-md slideanim">
    </div>
  </div>

  <div class="row">
    <div class="index-desc3 col-md text-justify text-white">
      <div class="index-desc slideanime">
        MoraEvents keeps you updated with various events, competitions and other programmes organized by the undergraduates of UOM.
        Moreover it creates a platform where the organizers can actively interact with all the interested parties.
      </div>
    </div>
  </div>

  <?php
  function buildServiceCard($icon, $title, $text){
    echo "
    <div class='col-lg-3 slideanim'>
      <div>
        <span class='fas $icon logo'></span>
        <h4>$title</h4>
        <p>$text</p>
      </div>
    </div>
    ";
  }
  
  ?>

    <div id="services" class="container-fluid text-center">
      <h2>FEATURES</h2>
      <br>

      <div class="row">
        <?php buildServiceCard('fa-calendar-alt', 'TRACK EVENTS', 'Easily track new events') ?>
        <?php buildServiceCard('fa-map-pin', 'PIN EVENTS', 'Pin an Event add reminders') ?>
        <?php buildServiceCard('fa-broadcast-tower', 'REAL TIME', 'With real time updates') ?>
        <?php buildServiceCard('fa-mobile', 'MOBILE APPS', 'Mobile apps in both iOS and Android') ?>
      </div>
    </div>

    <div class="row text-center">
      <div id="download" class="col-md text-white">
        <div class="index-desc slideanime">
          Download Apps for Free
          <br/>
          <br/>
          <span>
            <img src="images/download.png" alt="Download" class="img-fluid" />
          </span>
        </div>
      </div>
    </div>


</div>

<script>
  $('#getstarted').click(function() {
    $('html, body').animate({
          scrollTop: $('#download').offset().top
        }, 900, function () {

          // Add hash (#) to URL when done scrolling (default click behavior)
          window.location.hash = '#download';
        });
  });
</script>

<?php include("footer.php"); ?>