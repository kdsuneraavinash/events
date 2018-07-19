<?php include("header.php"); ?>

<script>
    $(document).ready(function () {
        loadAllEvents();
    });
</script>

<!-- Page to view all events in a grid -->
<div class="container">
    <div class="card p-3 content" id="events_content">
        <h2>All Events</h2>
        <hr/>
        <div id="events">
            <div class="row">
            </div>
        </div>
        <div>
            <hr>
            <p class="text-center"><small>No more Events to see. <a href="events.php">Click here</a> to refresh the page.
        </div>
    </div>
</div>

<?php include("footer.php"); ?>