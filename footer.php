<!-- Footer -->
<footer class="container-fluid text-center fixed-bottom py-2" id="footer">
  © 2018 by teamaxys
</footer>

<!-- TODO: Decide whether to add these to head -->
<!-- Add JavaScript CDN for Bootstrap (JQuery added on header)-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
  crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js" integrity="sha384-o+RDsa0aLu++PJvFqy8fFScvbHFLtbvScb8AjopnFD+iEQ7wo/CG0xlczd+2O/em"
  crossorigin="anonymous"></script>
<!-- Add Script files -->
<script src="js/firebase-auth.js"></script>
<?php
    // TODO: Add pollyfills for date time pickers
    if ($currentPage == "addevent"){
      echo '<script src="js/form-validate.js"></script>
            <script src="https://widget.cloudinary.com/v2.0/global/all.js"></script>
            <script src="js/cloudinary-upload.js"></script>';
    }else if ($currentPage == "showevent"){
      echo '<script src="js/firestore-db.js"></script>
            <script src="js/event-view.js"></script>';
    }else if ($currentPage == "events"){
      echo '<script src="js/firestore-db.js"></script>
            <script src="js/all-events.js"></script>';
    }else if ($currentPage == "post"){
      
      echo '<script src="js/firestore-db.js"></script>';
    }
  ?>
  <script src="js/event_trigger.js"></script>

  </body>

  </html>