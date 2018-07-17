<?php 
include("header.php"); 
// TODO: Add some rules to make sure form is not resubmitted 
 if ($_SERVER["REQUEST_METHOD"] != "POST") header("index.php"); 

    function tableCell($key, $value){
        echo "<tr>
                <td>$key</td>
                <td>$value</td>
            </tr>";
    }

    // Preprocess
    $eventName = $_POST['eventName'];
    $organizer = $_POST['organizer'];
    $description = $_POST['description'];
    $location = $_POST['location'];

    $startDate = $_POST['startDate'];
    $endDate = $_POST['endDate'];
    $isAllDay = array_key_exists('isAllDay', $_POST);
    $startTime = $_POST['startTime'];
    $endTime = $_POST['endTime'];
    $startTime = $isAllDay ? '00:00' : $startTime;
    $endTime = $isAllDay ? '23:59' : $endTime;

    $tags = explode(' ', strtolower($_POST['tags']));
    $images = !array_key_exists('uploaded_images', $_POST) ?  array() : $_POST['uploaded_images'];
    foreach ($images as $ind => $val) {
        $images[$ind] = "https://res.cloudinary.com/kdsuneraavinash/$val";
    }
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

        <form action="index.php">
            <div class="text-right">
                <button type="submit" class="btn btn-primary">OK</button>
            </div>
        </form>

    </div>
</div>

<!-- Store in firestore -->
<script src="js/firestore-db.js"></script>
<script>
    <?php 
    $tags = json_encode($tags);
    $images = json_encode($images);
    $description = str_replace(array("\r","\n"), "", $description);
    $isAllDay = $isAllDay == 1 ? "true" : "false";
    $startDateTime = date('Y-m-d H:i:s', strtotime("$startDate $startTime:00"));
    $endDateTime = date('Y-m-d H:i:s', strtotime("$endDate $endTime:00"));
    // TODO: Add /n /r in description
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