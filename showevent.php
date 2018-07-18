<?php 
    include("header.php");
    function tableCell($key, $value){
        echo "<tr>
                <td>$key</td>
                <td>$value</td>
            </tr>";
    }

    
?>

<div class="container" id="post_content">
    <div class="card p-3 content">
        <h2>Submitted Event</h2>
        <hr />

        <table class="table table-striped table-bordered table-hover">
            <thead class="thead-dark">
                <tr>
                    <th scope="col">Field</th>
                    <th scope="col">Data</th>
                </tr>
            </thead>
            <tbody>
                <?php tableCell("Event Name", $event->eventName); ?>
                <?php tableCell("Organizer", $event->organizer); ?>
                <?php tableCell("Description", $event->description); ?>
                <?php tableCell("Venue", $event->location); ?>
                <?php tableCell("Start Date", $event->startDate); ?>
                <?php tableCell("End Date", $event->endDate); ?>
                <?php tableCell("Is this all day?", $event->isAllDay ? "Yes" : "No"); ?>
                <?php tableCell("Start Time", $event->isAllDay ? '-Not applicable-' : $event->startTime); ?>
                <?php tableCell("End Time", $event->isAllDay ? '-Not applicable-' : $event->endTime); ?>
                <tr>
                    <td>Tags</td>
                    <td>
                        <?php 
                        foreach ($event->tags as $ind => $val) {
                            echo "<kbd>$val</kbd> ";
                        }
                    ?>
                    </td>
                </tr>
                <tr>
                    <td>Images</td>
                    <td>
                        <?php 
                        foreach ($event->images as $ind => $val) {
                            $tip = $ind == 0 ? "Cover Image" : "Image [$ind]";
                            echo "<button type='button' class='btn btn-outline-dark m-1 image-preview' 
                            value='$val' onClick='onImagePreviewClicked(this)'  data-toggle='modal' data-target='#imageView'>$tip</button>";
                        }
                    ?>
                    </td>
                </tr>
                <?php tableCell("User", "$event->user"); ?>
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


<?php 
include("footer.php"); 
unset($_SESSION["event"]);
?>