<?php include("header.php"); ?>

<script>
    $(document).ready(function () {
        loadAllEvents();
    });
</script>

<div class="container">
    <div class="card p-3 content" id="events_content">
        <h2>Current Events</h2>
        <hr/>
        <div id="events">
            <div class="row">
            </div>
        </div>
    </div>
</div>

<div id="users-device-size">
  <div id="1" class="d-none d-sm-block d-md-none"></div>
  <div id="2" class="d-none d-md-block d-lg-none"></div>
  <div id="3" class=".d-none d-lg-block d-xl-none"></div>
  <div id="3" class="d-none d-xl-block"></div>
</div>

<?php include("footer.php"); ?>