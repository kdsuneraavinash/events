<?php 
    include("header.php");
    if ($_SERVER["REQUEST_METHOD"] != "POST" || !isset($_SESSION["uid"])) {
        echo "<script>window.location.href = 'index.php';</script>";
        exit();
    }
    require("classes/Event.php");
?>
<!-- Store in firestore -->
<script>
    $(document).ready(function () {
        $("#loadingDataModel").show();
    });
    <?php
    if (isset($_POST["eventName"])){
        $event = new Event($_POST, $_SESSION);

        echo "
        console.log('Writing $event->eventName to Database');
        var eventData = {
            eventName: '$event->eventName',
            organizer: '$event->organizer',
            description: $event->descriptionJSON,
            location: '$event->location',
            start: new Date('$event->startDateTime'),
            end: new Date('$event->endDateTime'),
            isAllDay: $event->isAllDayJSON,
            tags: $event->tagsJSON,
            user: '$event->user',
            userid: '$event->userid',
            images: $event->imagesJSON
        };
        addRecord(eventData, function(docRef){
            window.location.href = 'showevent.php?eventid=' + docRef.id;
        });"; 
    }
    ?>
</script>
<?php include("footer.php"); ?>