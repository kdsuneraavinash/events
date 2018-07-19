// Load the docID into page - called after GET
function loadIntoEventView(docID) {
    $("#docID").text("Document ID: " + docID);
    $("#loadingDataModel").show();
    $("#showevent_content").hide();
    readDocument(docID, applyDataToViewData);
}

// Apply data to the page
// Every field is checked before using
// TODO: Add a good way to format date and time
// TODO: Add a good way to view images
function applyDataToViewData(doc) {
    var data = doc.data();
    if (defined(data.eventName)) $("#eventName").text(data.eventName);
    if (defined(data.description)) $("#description").text(data.description);
    if (defined(data.organizer)) $("#organizer").text(data.organizer);
    if (defined(data.location)) $("#location").text(data.location);

    if (defined(data.user)) $("#user").text(data.user);

    if (defined(data.start) && defined(data.end)) $("#start").text(data.start.toDate());
    if (defined(data.start) && defined(data.end)) $("#end").text(data.end.toDate());
    if (defined(data.isAllDay)) $("#isAllDay").text(data.isAllDay ? "Yes" : "No");

    if (defined(data.tags)) {
        var tagsHTML = [];
        for (i = 0; i < data.tags.length; i++) {
            var item = "<kbd>" + data.tags[i] + "</kbd>"
            tagsHTML.push(item);
        }
        var tags = tagsHTML.join(" ");
        $("#tags").html(tags);
    }

    if (defined(data.images)) {
        var imagesHTML = [];
        for (i = 0; i < data.images.length; i++) {
            var item = " <button type='button' class='btn btn-outline-dark m-1 image-preview'" +
                " value=" + data.images[i] + " onClick='onImagePreviewClicked(this)'  data-toggle='modal' data-target='#imageView'>" +
                ((i == 0) ? "Cover Image" : ("Image " + i)) +
                "</button>";
            imagesHTML.push(item);
            data.tags[i] = "<kbd>" + data.tags[i] + "</kbd>";
        }
        var images = imagesHTML.join(" ");
        $("#images").html(images);
    }

    $("#showevent_content").show();
    $("#loadingDataModel").hide();
}

function defined(variable) {
    return (typeof variable !== 'undefined');
}