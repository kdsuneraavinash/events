<?php 
    session_start();
    if (!isset($_GET["eventid"])) {
        echo "<script>window.location.href = 'index.php';</script>";
        exit();
    }
    $docID = $_GET["eventid"];

?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Mora Events</title>

    <link rel="icon" href="https://cdn1.iconfinder.com/data/icons/flat-business-icons/128/calendar-512.png">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css" integrity="sha384-Smlep5jCw/wG7hdkwQ/Z5nLIefveQRIY9nfy6xoR1uRYBtpZgI6339F5dgvm/e9B"
        crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.0/css/solid.css" integrity="sha384-TbilV5Lbhlwdyc4RuIV/JhD8NR+BfMrvz4BL5QFa2we1hQu6wvREr3v6XSRfCTRp"
        crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.0/css/fontawesome.css" integrity="sha384-ozJwkrqb90Oa3ZNb+yKFW2lToAWYdTiF1vt8JiH5ptTGHTGcN7qdoR1F95e0kYyG"
        crossorigin="anonymous">
    <link rel="stylesheet" href="css/event-page.css" />

    <script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
        crossorigin="anonymous"></script>

    <script src="https://www.gstatic.com/firebasejs/5.2.0/firebase-app.js"></script>
    <script src="https://www.gstatic.com/firebasejs/5.2.0/firebase-auth.js"></script>
    <script src='https://www.gstatic.com/firebasejs/5.2.0/firebase-firestore.js'></script>
    <script src="js/api-keys.js"></script>
    <script src="js/firebase-init.js"></script>

</head>

<body>
    <?php include("model_forms/loading_data.html");?>

    <noscript>
        <?php include("error/no-javascript.html");?>
    </noscript>



    <div id="showevent_content">

        <div id="back" class="container-fluid">
            <a href="events.php" class="text-white">
                <h4> Back to Events </h4>
            </a>
        </div>


        <div id="front-caption">
            <div class="caption text-center" id="eventName">
            </div>
            <span class="fas fa-angle-double-down arrows"></span>
        </div>

        <div id="boxes" class="row text-center">
            <div class="col-md start-time box slideanim">
                <i class="fas fa-hourglass-start"></i>
                <h2 id="startDate"></h2>
                <h2 id="startTime"></h2>
            </div>
            <div class="col-md end-time box slideanim">
                <i class="fas fa-hourglass-end"></i>
                <h2 id="endDate"></h2>
                <h2 id="endTime"></h2>
            </div>
            <div class="col-md location box slideanim">
                <i class="fas fa-map-marker-alt"></i>
                <h2 id="location"></h2>
            </div>
            <div class="col-md organizer box slideanim">
                <i class="fas fa-sitemap"></i>
                <h2 id="organizer"></h2>
            </div>
        </div>

        <div class="row text-center slideanim">
            <p class="lead text-justify" id="description">
                <p>
        </div>

        <div class="row m-2" id="images">
        </div>

        <footer class="container-fluid text-center py-2 bg-white mt-5" id="footer">
            &#9400; 2018 by teamaxys
        </footer>
    </div>

    <script>
        // Taken from https://www.w3schools.com/bootstrap/bootstrap_theme_company.asp
        $(window).scroll(function () {
            $(".slideanim").each(function () {
                var pos = $(this).offset().top;

                var winTop = $(window).scrollTop();
                if (pos < winTop + 600) {
                    $(this).addClass("slide");
                }
            });
        });

        $(document).ready(function () {
            loadIntoEventView('<?php echo $docID;?>');
        });
    </script>


    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
        crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js" integrity="sha384-o+RDsa0aLu++PJvFqy8fFScvbHFLtbvScb8AjopnFD+iEQ7wo/CG0xlczd+2O/em"
        crossorigin="anonymous"></script>
    <script src="js/firestore-db.js"></script>
    <script src="js/event-view.js"></script>
    <script src="js/event-trigger.js"></script>
</body>

</html>