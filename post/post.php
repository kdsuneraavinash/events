<?php 
    session_start();
    if ($_SERVER["REQUEST_METHOD"] != "POST") {
        echo "<script>window.location.href = '../index.php';</script>";
        exit();
    }
    if (!isset($_SESSION["uid"])) header("index.php");
    require("Event.php")
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Mora Event</title>
    <style>
        div {
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.5);
            padding: 30px;
            display: table;
            margin-right: auto;
            margin-left: auto;
            margin-top: 30vh;
            color: #ffffff;
            font-family: fantasy;
            border-radius: 5px;
            background: linear-gradient(to top, #0c7487 0%, #0e5977 51%, #103f54 100%);
        }

    </style>
</head>

<!-- Simple design to load faster 
TODO: Make more beautiful
-->

<body>
    <div>
        <h1> Please Wait... Redirecting you </h1>
        <hr />
        <p>If you are not automatically redirected within 10 seconds,
            <a href="../index.php">
                <button type="button">Click Here</button>
            </a>
        </p>
    </div>

    <!-- JQuery CDN -->
    <script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
        crossorigin="anonymous"></script>
    <!-- Firebase - Must come before all script tags-->
    <!-- Firebase App is always required and must be first -->
    <script src="https://www.gstatic.com/firebasejs/5.2.0/firebase-app.js"></script>
    <script src="https://www.gstatic.com/firebasejs/5.2.0/firebase-auth.js"></script>
    <script src='https://www.gstatic.com/firebasejs/5.2.0/firebase-firestore.js'></script>
    <script src="../js/api-keys.js"></script>
    <script src="../js/firebase-init.js"></script>
    <script src="../js/firestore-db.js"></script>

    <!-- Store in firestore -->
    <script>
        <?php
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
            window.location.href = '../post.php?eventid=' + docRef.id;
        });
        
    "; 
    ?>
    </script>
</body>

</html>