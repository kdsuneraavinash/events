<?php 
if (!isset($_GET["eventid"])) {
    echo "<script>window.location.href = 'index.php';</script>";
    exit();
}

include("header.php");
$docID = $_GET["eventid"];
?>

<script>
    var docID = '<?php echo $docID;?>';
    $(document).ready(function () {
        loadIntoEventView(docID);
    });
</script>

<div class="container" id="showevent_content">
    <div class="card p-3 content">
        <h2>Submitted Form</h2>
        <hr />
        <h4 class="text-info" id="docID">
        </h4>
        <hr />
        <table class="table table-striped table-bordered table-hover">
            <thead class="thead-dark">
                <tr>
                    <th scope="col">Field</th>
                    <th scope="col">Data</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Event Name</td>
                    <td id="eventName"></td>
                </tr>
                <tr>
                    <td>Organizer</td>
                    <td id="organizer"></td>
                </tr>
                <tr>
                    <td>Description</td>
                    <td id="description"></td>
                </tr>
                <tr>
                    <td>Venue</td>
                    <td id="location"></td>
                </tr>
                <tr>
                    <td>Start Date</td>
                    <td id="start"></td>
                </tr>
                <tr>
                    <td>End Date</td>
                    <td id="end"></td>
                </tr>
                <tr>
                    <td>Is this all day?</td>
                    <td id="isAllDay">No</td>
                </tr>
                </tr>
                <tr>
                    <td>Tags</td>
                    <td id="tags"></td>
                </tr>
                <tr>
                    <td>Images</td>
                    <td id="images"></td>
                </tr>
                <tr>
                    <td>User</td>
                    <td id="user">
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


<?php include("footer.php"); ?>