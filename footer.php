<!-- Footer -->
<footer class="container-fluid text-center fixed-bottom py-2" id="footer">
  © 2018 by teamaxys
</footer>

<!-- TODO: Decide whether to add these to head -->
<!-- Add JQuery and JavaScript CDN -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
  crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js" integrity="sha384-o+RDsa0aLu++PJvFqy8fFScvbHFLtbvScb8AjopnFD+iEQ7wo/CG0xlczd+2O/em"
  crossorigin="anonymous"></script>
<!-- Add Script files -->
<script src="js/firebase-auth.js"></script>
<?php
      // TODO: Add pollyfills for date time pickers
      if (isOnPage("addevent")){
        echo '<script src="js/form-validate.js"></script>';
        echo '<script src="https://widget.cloudinary.com/v2.0/global/all.js"></script>';
        echo '<script src="js/cloudinary-upload.js"></script>';
      }
    ?>
  <script src="js/events.js"></script>

  </body>

  </html>