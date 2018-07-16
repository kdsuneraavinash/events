<?php include("header.php"); ?>
<!-- TODO: Add some rules to make sure form is not resubmitted -->
<?php if ($_SERVER["REQUEST_METHOD"] != "POST") header("index.php") ?>

<?php 
        function tableCell($key, $value){
            echo "<tr>
                    <td>$key</td>
                    <td>$value</td>
                </tr>";
        }

        $eventName = $_POST['eventName'];
        $organizer = $_POST['organizer'];
        $description = $_POST['description'];
        $location = $_POST['location'];
        $startDate = $_POST['startDate'];
        $endDate = $_POST['endDate'];
        $isAllDay = array_key_exists('isAllDay', $_POST);
        $startTime = $_POST['startTime'];
        $endTime = $_POST['endTime'];
        $tags = explode(' ', strtolower($_POST['tags']));
        $images = !array_key_exists('uploaded_images', $_POST) ?  array() : $_POST['uploaded_images'];
        foreach ($images as $ind => $val) {
            $images[$ind] = "https://res.cloudinary.com/kdsuneraavinash/$val";
        }
        $startTime = $isAllDay ? '00:00' : $startTime;
        $endTime = $isAllDay ? '23:59' : $endTime;
?>

<div class="container">
    <div class="card p-3 content">
        <h2>Submitted Form</h2>
        <hr />

        <table class="table table-striped table-bordered table-hover">
            <thead class="thead-dark">
                <tr>
                    <th scope="col">Field</th>
                    <th scope="col">Data</th>
                </tr>
            </thead>
            <tbody>
                <?php tableCell("Event Name", $eventName); ?>
                <?php tableCell("Organizer", $organizer); ?>
                <?php tableCell("Description", $description); ?>
                <?php tableCell("Venue", $location); ?>
                <?php tableCell("Start Date", $startDate); ?>
                <?php tableCell("End Date", $endDate); ?>
                <?php tableCell("Is all Day", $isAllDay ? "Yes" : "No"); ?>
                <?php tableCell("Start Time", $isAllDay ? '-Not applicable-' : $startTime); ?>
                <?php tableCell("End Time", $isAllDay ? '-Not applicable-' : $endTime); ?>
                <tr>
                    <td>Tags</td>
                    <td>
                    <?php 
                        foreach ($tags as $ind => $val) {
                            echo "<kbd>$val</kbd> ";
                        }
                    ?>
                    </td>
                </tr>
                <tr>
                    <td>Images</td>
                    <td>
                    <?php 
                        foreach ($images as $ind => $val) {
                            // TODO: Open link in a modal window
                            $tip = $ind == 0 ? "Cover Image" : "Image [$ind]";
                            echo "<button type='button' class='btn btn-outline-dark m-1 image-preview' 
                            value='$val' onClick='onImagePreviewClicked(this)'  data-toggle='modal' data-target='#imageView'>$tip</button>";
                        }
                    ?>
                    </td>
                </tr>
            </tbody>
        </table>

        <hr />

        <form action = "index.php">
          <div class="text-right">
            <button type="submit" class="btn btn-primary">OK</button>
          </div>
        </form>

    </div>
</div>

<!-- Firestore - Must come before all script tags-->
<!-- Firebase App is always required and must be first -->
<script src="https://www.gstatic.com/firebasejs/5.2.0/firebase-app.js"></script>
<!-- Add additional services that we want to use -->
<script src="https://www.gstatic.com/firebasejs/5.2.0/firebase-firestore.js"></script>
<!-- NOT NEEDED
    <script src="https://www.gstatic.com/firebasejs/5.2.0/firebase-auth.js"></script>
    <script src="https://www.gstatic.com/firebasejs/5.2.0/firebase-firestore.js"></script>
    <script src="https://www.gstatic.com/firebasejs/5.2.0/firebase-messaging.js"></script>
    <script src="https://www.gstatic.com/firebasejs/5.2.0/firebase-functions.js"></script>
    <script src="https://www.gstatic.com/firebasejs/5.2.0/firebase-storage.js"></script>
    <script src="https://www.gstatic.com/firebasejs/5.2.0/firebase-database.js"></script>
    -->
<script src="js/firestore-db.js"></script>
<script>
    <?php 
    $tags = json_encode($tags);
    $images = json_encode($images);
    $description = str_replace(array("\r","\n"), "", $description);
    $isAllDay = $isAllDay == 1 ? "true" : "false";
    $startDateTime = date('Y-m-d H:i:s', strtotime("$startDate $startTime:00"));
    $endDateTime = date('Y-m-d H:i:s', strtotime("$endDate $endTime:00"));
    echo "
        var eventData = {
            eventName: '$eventName',
            organizer: '$organizer',
            description: '$description',
            location: '$location',
            start: new Date('$startDateTime'),
            end: new Date('$endDateTime'),
            isAllDay: $isAllDay,
            tags: $tags,
            images: $images };
        addRecord(eventData);
        ";
    ?>
</script>        
<?php include("footer.php"); ?>
