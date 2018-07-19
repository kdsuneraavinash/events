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

<?php include("footer.php"); ?>